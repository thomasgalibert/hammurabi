class ConclusionPresenter < Keynote::Presenter
  presents :conclusion

  def fichier_description
    if conclusion.fichier.attached?
      "#{conclusion.fichier.blob.filename} (#{number_to_human_size(conclusion.fichier.blob.byte_size)})"
    else
      "--"
    end
  end
end