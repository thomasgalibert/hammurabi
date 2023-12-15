# frozen_string_literal: true

class StatComponent < ViewComponent::Base
  def initialize(name:, progression:, amount:, subtitle:)
    @name = name
    @progression = progression
    @amount = amount
    @subtitle = subtitle
  end

end
