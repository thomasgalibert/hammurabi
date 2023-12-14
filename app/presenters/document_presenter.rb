class DocumentPresenter < Keynote::Presenter
  presents :document

  def name
    content_tag :span, document.name, class: "font-medium"
  end

  def dossier
    content_tag :span, document.dossier.name, class: "font-semibold text-stone-600"
  end

  def created_at
    I18n.l(document.created_at, format: :short)
  end

  def format
    document.description
  end

  def download
    link_to document.filename, url_for(document.fichier), target: "_blank", class: "text-blue-500 hover:text-blue-700"
  end

  def url
    url_for(document.dossier)
  end
end