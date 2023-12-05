require "test_helper"

class FacturationSettingTest < ActiveSupport::TestCase
  def setup
    @user = FactoryBot.create(:user)
    @facturation_setting = FactoryBot.create(:facturation_setting, user: @user, first_invoice_number: 3)
    @firm_setting = FactoryBot.create(:firm_setting, user: @user)
    @dossier = FactoryBot.create(:dossier, user: @user)
    @contact = FactoryBot.create(:contact, user: @user)
  end

  test "vérifie que lorsqu'il y a au moins une facture achived on ne peut pas changer facturation_setting.firt_invoice_number" do
    Facture.destroy_all
    facture = FactoryBot.create(:facture, emetteur: @user, user: @user, dossier: @dossier, contact: @contact)
    facture.complete!
    @facturation_setting.first_invoice_number = 4
    assert_not @facturation_setting.valid?
  end
end
