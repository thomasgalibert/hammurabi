# frozen_string_literal: true

class TableComponent < ViewComponent::Base
  def initialize(objects:, list_attributes:, class_name:, actions_controller:)
    @objects = objects
    @list_attributes = list_attributes
    @class_name = class_name
    @actions_controller = actions_controller
  end

  def display_attribute(object, attribute)
    content = object.send(attribute)

    case attribute
    when :state
      display_badge(object, attribute)
    else
      display_normal_content(content, attribute)
    end
  end

  private

  def find_type(attribute)
    attribute_type = ActiveRecord::Type.lookup(@class_name.constantize.columns_hash[attribute.to_s].type)
    attribute_type.class.to_s.demodulize
  end

  def display_normal_content(content, attribute)
    case find_type(attribute)
    when "String"
      content_tag :div, content
    when "DateTime", "Date"
      content_tag :div, I18n.l(content)
    else
      content_tag :div, content
    end
  end

  def display_badge(object, attribute)
    k(object).badge
  end

end
