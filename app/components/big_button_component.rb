# frozen_string_literal: true

class BigButtonComponent < ViewComponent::Base
  def initialize(name:, url:)
    @name = name
    @url = url
  end

end
