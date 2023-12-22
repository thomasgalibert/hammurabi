class DossierShareLinkPresenter < Keynote::Presenter
presents :dossier_share_link

  def url
    path = sharing_dossier_share_link_url(dossier_share_link, token: dossier_share_link.token)
    input_class = "border rounded px-2 py-1 w-full border-stone-300 text-sky-600"
    
    content_tag :input, "", type: :text, disabled: true, class: input_class, value: path
  end
end