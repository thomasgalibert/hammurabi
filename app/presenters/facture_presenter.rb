class FacturePresenter < Keynote::Presenter
  presents :facture

  def badge
    specific_class = case facture.state
      when 'draft' then "bg-gray-50 text-gray-700 ring-gray-600/20"
      when 'achived' then "bg-emerald-50 text-emerald-700 ring-emerald-600/20"
      else "bg-gray-50 text-gray-700 ring-gray-600/20"
    end

    common_class = "inline-flex flex-shrink-0 items-center rounded-full px-1.5 py-0.5 text-xs font-medium ring-1 ring-inset"
    badge_class = "#{common_class} #{specific_class}"

    content_tag :span, t("factures.states.#{facture.state}"), class: badge_class
  end
end