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
    DossierContact.find_by(dossier_id: @dossier.id, contact_id: contact2.id).update(is_main: true)
    
    assert_equal contact2, @dossier.contact_principal
  end

  test "un contact peut avoir soit un nom et prénom, soit une raison sociale" do
    contact1 = FactoryBot.create(:contact, user: @user, company_name: nil)
    contact2 = FactoryBot.create(:contact, user: @user, last_name: nil, first_name: nil, company_name: "CARPA Paris")
    
    assert contact1.valid?
    assert contact2.valid?
  end
end
