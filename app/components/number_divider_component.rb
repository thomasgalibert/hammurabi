# frozen_string_literal: true

class NumberDividerComponent < ViewComponent::Base
  def initialize(number:, title:)
    @number = number
    @title = title
  end
end
