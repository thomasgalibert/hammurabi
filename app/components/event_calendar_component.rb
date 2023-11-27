# frozen_string_literal: true

class EventCalendarComponent < ViewComponent::Base
  def initialize(event:)
    @event = event
  end

end
