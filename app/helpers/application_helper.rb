module ApplicationHelper
  include Pagy::Frontend
  
  def at(object, attribute)
    I18n.t("activerecord.attributes.#{object.class.to_s.downcase}.#{attribute}")
  end  

  def translate_options_for_select(object, attribute, options)
    object_name = object.class.to_s.downcase
    options.map { |option| 
      [I18n.t("activerecord.attributes.#{object_name}.#{attribute.to_s}.#{option}"), option] 
    }
  end

  def display_boolean(boolean)
    boolean ? I18n.t('helpers.boolean.is_yes') : I18n.t('helpers.boolean.is_no')
  end

  def display_font_awesome_icon(icon, additional_classes = nil)
    "<i class='#{icon} #{additional_classes}'></i>".html_safe
  end
end
