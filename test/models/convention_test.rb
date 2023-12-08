require "test_helper"

class ConventionTest < ActiveSupport::TestCase
  def setup
    @user = FactoryBot.create(:user)
    @dossier = FactoryBot.create(:dossier, user: @user)
  end

  test "un dossier peut avoir plusieurs conventions" do
    convention1 = FactoryBot.create(:convention, user: @user, dossier: @dossier)
    convention2 = FactoryBot.create(:convention, user: @user, dossier: @dossier)

    assert_equal 2, @dossier.conventions.count
    assert_includes @dossier.conventions, convention1
    assert_includes @dossier.conventions, convention2
  end

  test "une convention a un titre, une date et un forfait" do
    convention = FactoryBot.create(:convention, user: @user, dossier: @dossier)

    assert convention.title.present?
    assert convention.date.present?
    assert convention.forfait.present?
  end

  test "une convention a une référence qui est du type dossier.reference + 8 caractères (chiffre ou majuscules)'" do
    convention = FactoryBot.create(:convention, user: @user, dossier: @dossier)

    assert convention.reference.present?
    assert_equal 24, convention.reference.length
  end
end