# frozen_string_literal: true

class ConclusionComponent < ViewComponent::Base
  def initialize(conclusion:)
    @conclusion = conclusion
  end
end
