require "test_helper"

class DossierTest < ActiveSupport::TestCase
  
  def setup
    @user = FactoryBot.create(:user)
    @facturation_setting = FactoryBot.create(:facturation_setting, user: @user, first_invoice_number: 3)
    @firm_setting = FactoryBot.create(:firm_setting, user: @user)
    @dossier = FactoryBot.create(:dossier, user: @user)
    @contact = FactoryBot.create(:contact, user: @user)
  end

  test "chaque fois qu'un dossier est vu ou modifié, la colonne viewed_at est mise à jour" do
    dossier = FactoryBot.create(:dossier, user: @user)
    old_viewed_at = dossier.viewed_at
    dossier.save
    assert_not_equal dossier.viewed_at, old_viewed_at
  end

  test "un dossier qui n'a pas de facture a un state de pending" do
    dossier = FactoryBot.create(:dossier, user: @user)
    assert_equal dossier.state, "pending"
  end

  test "un dossier qui a une facture en achived a un state de partial si le montant de la convention est supérieur au montant ttc de la facture" do
    Facture.delete_all
    dossier = FactoryBot.create(:dossier, user: @user)
    convention = FactoryBot.create(:convention, dossier: dossier, forfait_cents: 1000, user: @user)
    facture = FactoryBot.create(:facture, dossier: dossier, total_ttc_cents: 900, user: @user, emetteur: @user, contact: @contact)
    facture.complete!
    
    assert_equal "unpaid", dossier.state
  end

end
