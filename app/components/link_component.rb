# frozen_string_literal: true

class LinkComponent < ViewComponent::Base
  def initialize(name:, url:, color:, icon: nil)
    @name = name
    @url = url
    @color = color
    @icon = icon
  end

end
