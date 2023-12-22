# frozen_string_literal: true

class EventComponent < ViewComponent::Base
  def initialize(event:, current_user:)
    @event = event
    @current_user = current_user
  end

end
