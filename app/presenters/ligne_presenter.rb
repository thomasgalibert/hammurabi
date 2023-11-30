class LignePresenter < Keynote::Presenter
  presents :ligne

  def unit
    if ligne.unit.present?
      t("helpers.ligne.unit.#{ligne.unit}")
    else
      t("helpers.ligne.unit.forfait")
    end
  end

end