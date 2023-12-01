# test/models/facture_test.rb
require 'test_helper'

class LigneTest < ActiveSupport::TestCase

  def setup
    @user = FactoryBot.create(:user)
    @dossier = FactoryBot.create(:dossier, user: @user)
    @contact = FactoryBot.create(:contact, user: @user)
    @facture = FactoryBot.create(:facture, emetteur: @user, dossier: @dossier, contact: @contact, user: @user)
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

  test "vérifie que l'attribut unit peut avoir 2 valeurs 'hour' et 'forfait'" do
    ligne_tva_standard = FactoryBot.create(:ligne, :tva_standard, facturable: @facture)
    ligne_tva_standard.unit = "hour"
    assert_equal "hour", ligne_tva_standard.unit
    ligne_tva_standard.unit = "forfait"
    assert_equal "forfait", ligne_tva_standard.unit
  end

  test "vérifie que l'attribut unit ne peut pas avoir d'autres valeurs que 'hour' et 'forfait'" do
    ligne_tva_standard = FactoryBot.create(:ligne, :tva_standard, facturable: @facture)
    ligne_tva_standard.unit = "jour"
    assert_not ligne_tva_standard.valid?
  end

  test "vérifie que l'on ne peut pas créer ou modifier une ligne d'une facture qui a un state achived" do
    @facture.update(state: "achived")
    ligne_tva_standard = FactoryBot.build(:ligne, :tva_standard, facturable: @facture)
    assert_not ligne_tva_standard.valid?
  end
end
