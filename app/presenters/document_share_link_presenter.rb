class DocumentShareLinkPresenter < Keynote::Presenter
  presents :document_share_link

  def url
    path = sharing_document_share_link_url(document_share_link, token: document_share_link.token)
    input_class = "border rounded px-2 py-1 w-full border-stone-300 text-sky-600 pr-14"
    copy_button_class = "absolute inset-y-0 right-0 flex py-1.5 pr-1.5 text-sm text-stone-500 border border-stone-300 px-2 rounded-r border-r-0 border-t-0 border-b-0 cursor-pointer"
    tooltip_class = "absolute animate-bounce right-20 -top-7 bg-stone-500 text-xs rounded-full px-1.5 py-1 text-white hidden"

    content_tag :div, class: "relative flex items-center", data: {controller: "clipboard"} do
      content_tag(:input, "", type: :text, disabled: true, class: input_class, value: path, data: {clipboard_target: "source"}) +
      content_tag(:div, "copier", class: copy_button_class, data: {action: "click->clipboard#copy"} ) +
      content_tag(:div, I18n.t('buttons.copied'), class: tooltip_class, data: {clipboard_target: "tooltip"})
    end
  end
end
