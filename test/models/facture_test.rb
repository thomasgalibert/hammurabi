# test/models/facture_test.rb
require 'test_helper'

class FactureTest < ActiveSupport::TestCase

  def setup
    @user = FactoryBot.create(:user)
    @facturation_setting = FactoryBot.create(:facturation_setting, user: @user, first_invoice_number: 3)
    @firm_setting = FactoryBot.create(:firm_setting, user: @user)
    @dossier = FactoryBot.create(:dossier, user: @user)
    @contact = FactoryBot.create(:contact, user: @user)
    @facture = FactoryBot.create(:facture, emetteur: @user, dossier: @dossier, contact: @contact, user: @user)
  end

  test "il y a bien une création de 3 lignes pour la facture" do
    ligne_tva_standard = FactoryBot.create(:ligne, :tva_standard, facturable: @facture)
    assert_equal 1, @facture.lignes.count
  end

  test "vérifie le total ttc de la première ligne" do
    ligne_tva_standard = FactoryBot.create(:ligne, :tva_standard, facturable: @facture)
    assert_equal 1200, ligne_tva_standard.total_ttc_cents
  end

  test "vérifie le total ttc de la facture" do
    ligne_tva_standard = FactoryBot.create(:ligne, :tva_standard, facturable: @facture)
    @facture.reload
    @facture.calculer_totaux
    
    assert_equal 1200, @facture.total_ttc_cents
  end

  test "vérifie le total ttc avec différentes tva et réduction" do
    FactoryBot.create(
      :ligne, 
      tva: 5.5, 
      reduction: 13, 
      quantite: 4, 
      prix_unitaire_cents: 15547, 
      facturable: @facture)

    FactoryBot.create(
      :ligne, 
      tva: 20, 
      reduction: 0, 
      quantite: 8, 
      prix_unitaire_cents: 20156, 
      facturable: @facture)

    @facture.reload
    @facture.calculer_totaux
    
    assert_equal 250577, @facture.total_ttc_cents
  end

  test "verifie que les sous-totaux de tva sont corrects" do
    FactoryBot.create(
      :ligne, 
      tva: 5.5, 
      reduction: 13, 
      quantite: 4, 
      prix_unitaire_cents: 15547, 
      facturable: @facture)

    FactoryBot.create(
      :ligne, 
      tva: 20, 
      reduction: 0, 
      quantite: 8, 
      prix_unitaire_cents: 20156, 
      facturable: @facture)

    @facture.reload
    @facture.calculer_totaux
    @facture.breakdown_tva

    assert_equal 54104, @facture.breakdown_tva[5.5][:base]
  end

  test "vérifie que l'on peut pas créer un facture avec un date antérieure à la précédente" do
    facture2 = FactoryBot.build(:facture, emetteur: @user, date: @facture.date - 1.day, dossier: @dossier, contact: @contact, user: @user)
    assert_not facture2.valid?
  end

  test "vérifie que le numéro de la facture est bien incrémenté par rapport à la dernière facture ajoutée" do
    Facture.delete_all
    facture1 = FactoryBot.create(:facture, state: :achived, emetteur: @user, dossier: @dossier, contact: @contact, user: @user)    
    facture2 = FactoryBot.create(:facture, state: :draft, emetteur: @user, dossier: @dossier, contact: @contact, user: @user)    
    facture3 = FactoryBot.create(:facture, state: :achived, emetteur: @user, dossier: @dossier, contact: @contact, user: @user)

    assert_equal 2, facture3.numero
  end

  test "vérifie que la facture n'a pas de numéro quand c'est un brouillon" do
    Facture.delete_all
    facture1 = FactoryBot.create(:facture, state: :draft, emetteur: @user, dossier: @dossier, contact: @contact, user: @user)    

    assert_nil facture1.numero
  end

  test "vérifie que la facture a un numéro quand elle est validée" do
    Facture.delete_all
    facture1 = FactoryBot.create(:facture, state: :draft, emetteur: @user, dossier: @dossier, contact: @contact, user: @user)
    facture1.complete!    

    assert_not_nil facture1.numero
    assert facture1.locked?
  end

  test "vérifie que la facture a un screen_number qui correspond son numéro qui tient compte du first_invoice_number de facturation_setting" do
    Facture.delete_all
    facture1 = FactoryBot.create(:facture, state: :draft, emetteur: @user, dossier: @dossier, contact: @contact, user: @user)
    facture1.complete!

    assert_equal "00000003", facture1.screen_number
  end

  test "vérifie que l'on ne peut pas modifier une facture validée" do
    @facture.complete!    
    @facture.update(date: @facture.date + 1.day)
    
    assert_not @facture.valid?
  end

  test "vérifie que la facture comporte une date de fin de validité" do
    assert_not_nil @facture.date_fin_validite
  end

  test "vérifie que la facture comporte des conditions de paiement" do
    assert_not_nil @facture.conditions_paiement
  end

  test "vérifie que le facture comporte des conditions générales" do
    assert_not_nil @facture.conditions_generales
  end

  test "vérifie que le facture payée en totalité a un payment_status égal à paid" do
    payment = FactoryBot.create(
                :payment, 
                facture: @facture, 
                user: @user,
                amount_cents: @facture.total_ttc_cents)

    assert_equal "paid", @facture.payment_status
  end

  test "vérifie que le facture payée en partie a un payment_status égal à partial" do
    payment = FactoryBot.create(
                :payment, 
                facture: @facture, 
                user: @user,
                amount_cents: @facture.total_ttc_cents - 1)

    assert_equal "partial", @facture.payment_status
  end

  test "vérifie que le facture non payée a un payment_status égal à unpaid" do
    assert_equal "unpaid", @facture.payment_status
  end

  test "vérifie qu'à la création de la facture, les conditions_paiement et conditions_generales sont ceux de facturation_setting" do
    facture = FactoryBot.build(
      :facture,
      emetteur: @user,
      dossier: @dossier,
      contact: @contact,
      user: @user,
      conditions_paiement: nil, 
      conditions_generales: nil)

    facture.save

    assert_equal @facturation_setting.conditions_generales.to_plain_text, facture.conditions_generales.to_plain_text
    assert_equal @facturation_setting.conditions_paiement.to_plain_text, facture.conditions_paiement.to_plain_text
  end

  test "vérifie que quand le numero est créé, le champ backup_number est bien rempli" do
    @facture.complete!
    assert_equal @facture.screen_number, @facture.backup_number
  end

  test "vérifie qu'il y a un attribut currency et que par défault, c'est EUR" do
    assert_equal "EUR", @facture.currency
  end

  test "vérifie que le facture a un order_reference mais il n'est pas obligatoire" do
    assert_nil @facture.order_reference
  end

  test "vérifie que quand la facture est validée, il y a un objet FactureSeal attaché qui est créé" do
    @facture.complete!
    assert_not_nil @facture.facture_seal
  end

  test "vérifie que FactureSeal a les champs suivants : emetteur_name, emetteur_address, etc" do
    @facture.complete!
    assert_equal @facture.emetteur.firm_setting.legal_name, @facture.facture_seal.emetteur_legal_name
    assert_equal @facture.emetteur.firm_setting.address, @facture.facture_seal.emetteur_address
    assert_equal @facture.emetteur.firm_setting.city, @facture.facture_seal.emetteur_city
    assert_equal @facture.emetteur.firm_setting.zip_code, @facture.facture_seal.emetteur_zip_code
    assert_equal @facture.emetteur.firm_setting.country, @facture.facture_seal.emetteur_country
    assert_equal @facture.emetteur.firm_setting.business_number, @facture.facture_seal.emetteur_business_number
    assert_equal @facture.emetteur.firm_setting.vat_number, @facture.facture_seal.emetteur_vat_number
    assert_equal @facture.emetteur.firm_setting.share_capital, @facture.facture_seal.emetteur_share_capital
  end

  test "vérifie que FactureSeal a les champs suivants : client_name, client_address, etc" do
    @facture.complete!
    assert_equal @facture.contact.name_with_company, @facture.facture_seal.client_name
    assert_equal @facture.contact.address, @facture.facture_seal.client_address
    assert_equal @facture.contact.city, @facture.facture_seal.client_city
    assert_equal @facture.contact.zip_code, @facture.facture_seal.client_zip_code
    assert_equal @facture.contact.country, @facture.facture_seal.client_country
    assert_equal @facture.contact.business_number, @facture.facture_seal.client_business_number
    assert_equal @facture.contact.vat_number, @facture.facture_seal.client_vat_number
  end

end
