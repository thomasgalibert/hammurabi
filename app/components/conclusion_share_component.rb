# frozen_string_literal: true

class ConclusionShareComponent < ViewComponent::Base
  with_collection_parameter :conclusion

  def initialize(conclusion:)
    @conclusion = conclusion
  end
end
