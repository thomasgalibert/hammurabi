# test/models/facture_emetteur_test.rb
require 'test_helper'

class FactureAssociationsTest < ActiveSupport::TestCase
  test "Vérifier que la facture appartient à un émetteur qui est relié à la table users" do
    user = FactoryBot.create(:user)
    dossier = FactoryBot.create(:dossier, user: user)
    facture = FactoryBot.create(:facture, emetteur: user, dossier: dossier)    
    assert_equal facture.emetteur.class, User
  end

  test "Vérifier que la facture est reliée à un dossier" do
    user = FactoryBot.create(:user)
    dossier = FactoryBot.create(:dossier, user: user)
    facture = FactoryBot.create(:facture, emetteur: user, dossier: dossier)    
    assert_equal facture.dossier.class, Dossier
  end
end