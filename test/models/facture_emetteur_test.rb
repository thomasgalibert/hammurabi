# test/models/facture_emetteur_test.rb
require 'test_helper'

class FactureEmetteurTest < ActiveSupport::TestCase
  test "Vérifier que la facture appartient à un émetteur qui est relié à la table users" do
    user = FactoryBot.create(:user)
    facture = FactoryBot.create(:facture, emetteur: user)    
    assert_equal facture.emetteur.class, User
  end
end