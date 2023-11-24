require "test_helper"

class ContactTest < ActiveSupport::TestCase
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
end
