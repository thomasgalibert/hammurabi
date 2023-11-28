# test/models/facture_emetteur_test.rb
require 'test_helper'

class FactureAssociationsTest < ActiveSupport::TestCase
  def setup
    @user = FactoryBot.create(:user)
    @contact = FactoryBot.create(:contact, user: @user)
    @dossier = FactoryBot.create(:dossier, user: @user)
    @dossier.contacts << @contact
    @facture = FactoryBot.create(:facture, emetteur: @user, dossier: @dossier, contact: @contact, user: @user)
  end

  test "Vérifier que la facture appartient à un émetteur qui est relié à la table users" do
    assert_equal @facture.emetteur.class, User
  end

  test "Vérifier que la facture est reliée à un dossier" do
    assert_equal @facture.dossier.class, Dossier
  end

  test "Vérifier que la facture est reliée à un contact" do
    assert_equal @facture.contact.class, Contact
  end
end