require "test_helper"

class DossierTest < ActiveSupport::TestCase
  
  def setup
    @user = FactoryBot.create(:user)
    @dossier = FactoryBot.create(:dossier, user: @user)
  end

  test "un dossier peut avoir plusieurs contacts" do
    contact1 = FactoryBot.create(:contact, user: @user)
    contact2 = FactoryBot.create(:contact, user: @user)
    
    @dossier.contacts << contact1
    @dossier.contacts << contact2
    
    assert_equal 2, @dossier.contacts.count
    assert_includes @dossier.contacts, contact1
    assert_includes @dossier.contacts, contact2
  end

  test "un dossier doit avoir au moins un contact principal" do
    contact1 = FactoryBot.create(:contact, user: @user)
    contact2 = FactoryBot.create(:contact, user: @user, main: true)
    
    @dossier.contacts << contact1
    @dossier.contacts << contact2
    
    assert_equal contact2, @dossier.contact_principal
  end

  test "chaque fois qu'un dossier est vu ou modifié, la colonne viewed_at est mise à jour" do
    dossier = FactoryBot.create(:dossier, user: @user)
    old_viewed_at = dossier.viewed_at
    dossier.save
    assert_not_equal dossier.viewed_at, old_viewed_at
  end

end
