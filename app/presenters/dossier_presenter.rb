class DossierPresenter < Keynote::Presenter
  presents :dossier

  def badge
    specific_class = case dossier.state
      when 'pending' then "bg-indigo-50 text-indigo-700 ring-indigo-600/20"
      when 'archived' then "bg-gray-50 text-gray-700 ring-gray-600/20"
      when 'partial' then "bg-orange-50 text-orange-700 ring-orange-600/20"
      when 'paid' then "bg-emerald-50 text-emerald-700 ring-emerald-600/20"
      when 'unpaid' then "bg-red-50 text-red-700 ring-red-600/20"
      else "bg-gray-50 text-gray-700 ring-gray-600/20"
    end

    common_class = "inline-flex flex-shrink-0 items-center rounded-full px-1.5 py-0.5 text-xs font-medium ring-1 ring-inset"
    badge_class = "#{common_class} #{specific_class}"

    content_tag :span, t("dossiers.states.#{dossier.state}"), class: badge_class
  end
end