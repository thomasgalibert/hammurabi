class ContactPresenter < Keynote::Presenter
  presents :contact

  def badge
    common_class = "inline-flex flex-shrink-0 items-center rounded-full px-1.5 py-0.5 text-xs font-medium ring-1 ring-inset"
    
    content_tag :span, class: "#{common_class} #{contact_class(contact)}" do
      t("activerecord.attributes.contact.kinds.#{contact.kind}")
    end
  end

  def star
    if contact.main?
      content_tag :div, class: "text-yellow-500" do
        content_tag :i, "", class: "fa-solid fa-star"
      end
    end
  end

  def full_address
    simple_format("#{contact.address} \n #{contact.zip_code} #{contact.city} (#{contact.country})")
  end

  def name_with_company
    if contact.company_name.present?
      "#{contact.company_name} - #{contact.name.full}"
    else
      contact.name.full
    end
  end

  private

  def contact_class(contact)
    case contact.kind
    when "customer" then "bg-green-50 text-green-700 ring-green-600/20"
    when "witness" then "bg-yellow-50 text-yellow-700 ring-yellow-600/20"
    when "partner" then "bg-blue-50 text-blue-700 ring-blue-600/20"
    when "other" then "bg-gray-50 text-gray-700 ring-gray-600/20"
    else "bg-gray-50 text-gray-700 ring-gray-600/20"
    end
  end

end