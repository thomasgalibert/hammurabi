# frozen_string_literal: true

class InstructionsComponent < ViewComponent::Base
  def initialize(message:)
    @message = message
  end
end
