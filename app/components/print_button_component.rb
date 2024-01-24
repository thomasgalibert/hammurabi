# frozen_string_literal: true

class PrintButtonComponent < ViewComponent::Base
  def initialize(url:)
    @url = url
  end
end
