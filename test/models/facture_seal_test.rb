require "test_helper"

class FactureSealTest < ActiveSupport::TestCase
  def setup
    Facture.destroy_all
    @user = FactoryBot.create(:user)
    @facturation_setting = FactoryBot.create(:facturation_setting, user: @user, first_invoice_number: 3)
    @firm_setting = FactoryBot.create(:firm_setting, user: @user)
    @dossier = FactoryBot.create(:dossier, user: @user)
    @contact = FactoryBot.create(:contact, user: @user)
    @facture = FactoryBot.create(:facture, emetteur: @user, dossier: @dossier, contact: @contact, user: @user)
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

  test "vérifie que même après modification de l'adresse de l'émetteur, FactureSeal a le champ emetteur_legal_name qui n'a pas changé" do
    old_legal_name = @facture.emetteur.firm_setting.legal_name
    @facture.complete!
    @facture.emetteur.firm_setting.update(legal_name: "My new legal name")
    @facture.update(date: @facture.date + 1.day)
    
    assert_equal old_legal_name, @facture.facture_seal.emetteur_legal_name
  end
end
