class ContactPresenter < Keynote::Presenter
  presents :contact

  def badge
    common_class = "inline-flex flex-shrink-0 items-center rounded-full px-1.5 py-0.5 text-xs font-medium ring-1 ring-inset"
    
    content_tag :span, class: "#{common_class} #{contact_class(contact)}" do
      t("activerecord.attributes.contact.kinds.#{contact.kind}")
    end
  end

  def star(dossier)
    if contact.is_main_for?(dossier)
      content_tag :div, class: "text-yellow-500 cursor-pointer hover:text-stone-200", data: {action: "click->contact#toggle"} do
        raw('<svg class="size-5 text-yellow-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M23.56 8.73a1.51 1.51 0 0 0 -1.41 -1h-6.09a0.5 0.5 0 0 1 -0.47 -0.33l-2.18 -6.2A1.52 1.52 0 0 0 12 0.25a1.49 1.49 0 0 0 -1.4 1L8.41 7.42a0.5 0.5 0 0 1 -0.47 0.33H1.85a1.5 1.5 0 0 0 -1.41 1 1.52 1.52 0 0 0 0.45 1.65l5.18 4.3a0.5 0.5 0 0 1 0.16 0.54l-2.18 6.53a1.5 1.5 0 0 0 2.31 1.69l5.34 -3.92a0.49 0.49 0 0 1 0.59 0l5.35 3.92A1.5 1.5 0 0 0 20 21.77l-2.18 -6.53a0.5 0.5 0 0 1 0.16 -0.54l5.19 -4.31a1.51 1.51 0 0 0 0.39 -1.66Z" fill="currentcolor" stroke-width="1"></path></svg>')
      end
    else
      content_tag :div, class: "text-stone-200 cursor-pointer hover:text-yellow-500", data: {action: "click->contact#toggle"} do
      raw('<svg class="size-5 text-gray-200" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M23.56 8.73a1.51 1.51 0 0 0 -1.41 -1h-6.09a0.5 0.5 0 0 1 -0.47 -0.33l-2.18 -6.2A1.52 1.52 0 0 0 12 0.25a1.49 1.49 0 0 0 -1.4 1L8.41 7.42a0.5 0.5 0 0 1 -0.47 0.33H1.85a1.5 1.5 0 0 0 -1.41 1 1.52 1.52 0 0 0 0.45 1.65l5.18 4.3a0.5 0.5 0 0 1 0.16 0.54l-2.18 6.53a1.5 1.5 0 0 0 2.31 1.69l5.34 -3.92a0.49 0.49 0 0 1 0.59 0l5.35 3.92A1.5 1.5 0 0 0 20 21.77l-2.18 -6.53a0.5 0.5 0 0 1 0.16 -0.54l5.19 -4.31a1.51 1.51 0 0 0 0.39 -1.66Z" fill="currentcolor" stroke-width="1"></path></svg>')
      end
    end
  end

  def full_address
    simple_format("#{contact.address} \n #{contact.zip_code} #{contact.city} (#{contact.country})")
  end

  def name_with_company
    contact.name_with_company
  end

  def international_phone = contact.phone
  def last_name = contact.last_name
  def first_name = contact.first_name
  def company_name = contact.company_name
  def created_at = I18n.l(contact.created_at, format: :short)
  def url = dashboard_contact_path(contact)

  private

  def contact_class(contact)
    case contact.kind
    when "customer" then "bg-green-50 text-green-700 ring-green-600/20"
    when "witness" then "bg-yellow-50 text-yellow-700 ring-yellow-600/20"
    when "partner" then "bg-blue-50 text-blue-700 ring-blue-600/20"
    when "adversary" then "bg-rose-50 text-rose-700 ring-rose-600/20"
    when "adversary_attorney" then "bg-rose-50 text-rose-700 ring-rose-600/20"
    when "other" then "bg-gray-50 text-gray-700 ring-gray-600/20"
    else "bg-gray-50 text-gray-700 ring-gray-600/20"
    end
  end

end