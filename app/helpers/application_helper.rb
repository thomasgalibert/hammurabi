module ApplicationHelper
  def at(object, attribute)
    I18n.t("activerecord.attributes.#{object.class.to_s.downcase}.#{attribute}")
  end  

  def translate_options_for_select(object, attribute, options)
    object_name = object.class.to_s.downcase
    options.map { |option| 
      [I18n.t("helpers.#{object_name}.#{attribute.to_s}.#{option}"), option] 
    }
  end
end
