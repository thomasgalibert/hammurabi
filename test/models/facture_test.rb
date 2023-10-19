# test/models/facture_test.rb
require 'test_helper'

class FactureTest < ActiveSupport::TestCase
  test "les calculs de la facture sont corrects avec différents taux de TVA et des réductions" do
    facture = FactoryBot.create(:facture)

    # Ajouter des lignes avec différents taux de TVA et réductions
    ligne_tva_standard = FactoryBot.create(:ligne, :tva_standard, :for_facture)

    assert_equal 1200, facture.total_ttc_cents
  end
end
