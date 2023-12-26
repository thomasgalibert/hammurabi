# frozen_string_literal: true

class LinkComponent < ViewComponent::Base
  def initialize(name:, url:, color:, icon: nil, target: "_self")
    @name = name
    @url = url
    @color = color
    @icon = icon
    @margin_icon = name.present? ? "mr-2" : ""
    @target = target
  end

end
