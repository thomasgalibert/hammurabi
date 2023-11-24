require "test_helper"

class EventTest < ActiveSupport::TestCase
  def setup
    @user = FactoryBot.create(:user)
    @dossier = FactoryBot.create(:dossier, user: @user)
  end

  test "un dossier doit avoir plusieurs events" do
    event1 = FactoryBot.create(:event, user: @user, dossier: @dossier)
    event2 = FactoryBot.create(:event, user: @user, dossier: @dossier)
    
    assert_equal 2, @dossier.events.count
    assert_includes @dossier.events, event1
    assert_includes @dossier.events, event2
  end
end
