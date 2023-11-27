class ConventionPresenter < Keynote::Presenter
  presents :convention

  def fichier_description
    if convention.fichier.attached?
      "#{convention.fichier.blob.filename} (#{number_to_human_size(convention.fichier.blob.byte_size)})"
    else
      "--"
    end
  end
end