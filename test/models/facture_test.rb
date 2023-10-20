# test/models/facture_test.rb
require 'test_helper'

class FactureTest < ActiveSupport::TestCase
  test "il y a bien une création de 3 lignes pour la facture" do
    facture = FactoryBot.create(:facture)    
    ligne_tva_standard = FactoryBot.create(:ligne, :tva_standard, facturable: facture)
    assert_equal 1, facture.lignes.count
  end

  test "vérifie le total ttc de la première ligne" do
    facture = FactoryBot.create(:facture)    
    ligne_tva_standard = FactoryBot.create(:ligne, :tva_standard, facturable: facture)
    assert_equal 1200, ligne_tva_standard.total_ttc_cents
  end

  test "vérifie le total ttc de la facture" do
    facture = FactoryBot.create(:facture)    
    ligne_tva_standard = FactoryBot.create(:ligne, :tva_standard, facturable: facture)
    facture.reload
    facture.calculer_totaux
    
    assert_equal 1200, facture.total_ttc_cents
  end

  test "vérifie le total ttc avec différentes tva et réduction" do
    facture = FactoryBot.create(:facture)    

    FactoryBot.create(
      :ligne, 
      tva: 5.5, 
      reduction: 13, 
      quantite: 4, 
      prix_unitaire_cents: 15547, 
      facturable: facture)

    FactoryBot.create(
      :ligne, 
      tva: 20, 
      reduction: 0, 
      quantite: 8, 
      prix_unitaire_cents: 20156, 
      facturable: facture)

    facture.reload
    facture.calculer_totaux
    
    assert_equal 250577, facture.total_ttc_cents
  end

  test "verifie que les sous-totaux de tva sont corrects" do
    facture = FactoryBot.create(:facture)    

    FactoryBot.create(
      :ligne, 
      tva: 5.5, 
      reduction: 13, 
      quantite: 4, 
      prix_unitaire_cents: 15547, 
      facturable: facture)

    FactoryBot.create(
      :ligne, 
      tva: 20, 
      reduction: 0, 
      quantite: 8, 
      prix_unitaire_cents: 20156, 
      facturable: facture)

    facture.reload
    facture.calculer_totaux
    facture.breakdown_tva

    assert_equal 54104, facture.breakdown_tva[5.5][:base]
  end

  test "vérifie que l'on peut pas créer un facture avec un date antérieure à la précédente" do
    facture = FactoryBot.create(:facture)    
    facture2 = FactoryBot.build(:facture, date: facture.date - 1.day)
    assert_not facture2.valid?
  end

  test "vérifie que le numéro de la facture est bien incrémenté par rapport à la dernière facture ajoutée" do
    Facture.delete_all
    facture1 = FactoryBot.create(:facture, state: :achived)    
    facture2 = FactoryBot.create(:facture, state: :draft)    
    facture3 = FactoryBot.create(:facture, state: :achived)

    assert_equal 2, facture3.numero
  end

  test "vérifie que la facture n'a pas de numéro quand c'est un brouillon" do
    Facture.delete_all
    facture1 = FactoryBot.create(:facture, state: :draft)    

    assert_nil facture1.numero
  end

  test "vérifie que la facture a un numéro quand elle est validée" do
    Facture.delete_all
    facture1 = FactoryBot.create(:facture, state: :draft)
    facture1.complete!    

    assert_not_nil facture1.numero
    assert facture1.locked?
  end

  test "vérifie que l'on ne peut pas modifier une facture validée" do
    facture = FactoryBot.create(:facture, state: :draft)
    facture.complete!    
    facture.update(date: facture.date + 1.day)
    
    assert_not facture.valid?
  end
end
