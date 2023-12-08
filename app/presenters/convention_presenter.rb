class ConventionPresenter < Keynote::Presenter
  presents :convention

  def fichier_description
    if convention.fichier.attached?
      "#{convention.fichier.blob.filename} (#{number_to_human_size(convention.fichier.blob.byte_size)})"
    else
      "--"
    end
  end

  def amount_with_date
    "#{number_to_currency(convention.forfait)} (#{I18n.l(convention.date)})"
  end
end