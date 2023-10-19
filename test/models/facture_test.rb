# test/models/facture_test.rb
require 'test_helper'

class FactureTest < ActiveSupport::TestCase
  test "les calculs de la facture sont corrects avec différents taux de TVA et des réductions" do
    facture = FactoryBot.create(:facture)

    # Ajouter des lignes avec différents taux de TVA et réductions
    ligne_tva_standard = FactoryBot.create(:ligne, :tva_standard, :for_facture)
    ligne_tva_reduite = FactoryBot.create(:ligne, :tva_reduite, :for_facture)
    ligne_avec_reduction = FactoryBot.create(:ligne, :tva_standard, :avec_reduction, :for_facture)

    # Calcul attendu :
    # Ligne standard : 10.00 + 20% = 12.00 EUR
    # Ligne TVA réduite : 10.00 + 10% = 11.00 EUR
    # Ligne avec réduction : (10.00 - 10%) + 20% = 10.80 EUR
    # Total attendu : 12.00 + 11.00 + 10.80 = 33.80 EUR

    assert_equal 3380, facture.total_ttc_cents
  end
end
