require "test_helper"

class DossierTest < ActiveSupport::TestCase
  
  def setup
    @user = FactoryBot.create(:user)
    @dossier = FactoryBot.create(:dossier, user: @user)
  end

  test "chaque fois qu'un dossier est vu ou modifié, la colonne viewed_at est mise à jour" do
    dossier = FactoryBot.create(:dossier, user: @user)
    old_viewed_at = dossier.viewed_at
    dossier.save
    assert_not_equal dossier.viewed_at, old_viewed_at
  end

end
