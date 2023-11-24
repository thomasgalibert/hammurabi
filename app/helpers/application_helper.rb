module ApplicationHelper
  def at(object, attribute)
    I18n.t("activerecord.attributes.#{object.class.to_s.downcase}.#{attribute}")
  end  
end
