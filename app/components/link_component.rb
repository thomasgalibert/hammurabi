# frozen_string_literal: true

class LinkComponent < ViewComponent::Base
  def initialize(name:, url:, color:)
    @name = name
    @url = url
    @color = color
  end

end
