require "test_helper"

class DossierTest < ActiveSupport::TestCase
  
  def setup
    @user = FactoryBot.create(:user)
    @dossier = FactoryBot.create(:dossier, user: @user)
  end

  test "dossier can have multiple contacts through dossier_contacts" do
    contact1 = FactoryBot.create(:contact, user: @user)
    contact2 = FactoryBot.create(:contact, user: @user)
    
    @dossier.contacts << contact1
    @dossier.contacts << contact2
    
    assert_equal 2, @dossier.contacts.count
    assert_includes @dossier.contacts, contact1
    assert_includes @dossier.contacts, contact2
  end

end
