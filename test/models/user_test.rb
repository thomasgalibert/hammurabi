require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = FactoryBot.create(:user)
    @facturation_setting = FactoryBot.create(:facturation_setting, user: @user)
    @firm_setting = FactoryBot.create(:firm_setting, user: @user)
  end

  test "un utilisateur doit avoir un last_name, first_name email et firm" do
    assert @user.valid?
    @user.last_name = nil
    assert_not @user.valid?
    @user.last_name = "Allred"
    assert @user.valid?
    @user.first_name = nil
    assert_not @user.valid?
    @user.first_name = "Gloria"
    assert @user.valid?
    @user.email = nil
    assert_not @user.valid?
    @user.email = ""
    assert_not @user.valid?
  end

  test "un utilisateur peut avoir plusieurs dossiers" do
    dossier1 = FactoryBot.create(:dossier, user: @user)
    dossier2 = FactoryBot.create(:dossier, user: @user)

    assert_equal 2, @user.dossiers.count
    assert_includes @user.dossiers, dossier1
    assert_includes @user.dossiers, dossier2
  end

  test "on peut afficher le nom complet d'un utilisateur" do
    assert_equal "Gloria Allred", @user.name.full
  end

  test "on peut afficher le nom du cabinet de l'utilisateur" do
    assert_equal "Allred Maroko & Goldberg", @user.firm
  end

  test "un utilisateur a un seul FacturationSetting" do
    assert_equal true, @user.facturation_setting.present?
  end

  test "un utilisateur a un seul FirmSetting" do
    assert_equal true, @user.firm_setting.present?
  end
end
