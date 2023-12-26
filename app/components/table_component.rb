# frozen_string_literal: true

class TableComponent < ViewComponent::Base
  def initialize(objects:, list_attributes:, class_name:, url_method: nil)
    @objects = objects
    @list_attributes = list_attributes
    @class_name = class_name
    @url_method = url_method
  end

  def display_attribute(object, attribute)
    k(object).send(attribute)
  end

end
