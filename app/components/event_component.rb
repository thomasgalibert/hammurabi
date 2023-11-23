# frozen_string_literal: true

class EventComponent < ViewComponent::Base
  def initialize(event:)
    @event = event
  end

end
