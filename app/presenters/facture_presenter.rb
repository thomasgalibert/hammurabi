class FacturePresenter < Keynote::Presenter
  include ApplicationHelper
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

  def payment_badge
    specific_class = case facture.payment_status
      when 'unpaid' then "bg-rose-50 text-rose-700 ring-rose-600/20"
      when 'partial' then "bg-orange-50 text-orange-700 ring-orange-600/20"
      when 'paid' then "bg-emerald-50 text-emerald-700 ring-emerald-600/20"
      else "bg-gray-50 text-gray-700 ring-gray-600/20"
    end

    common_class = "inline-flex flex-shrink-0 items-center rounded-full px-1.5 py-0.5 text-xs font-medium ring-1 ring-inset"
    badge_class = "#{common_class} #{specific_class}"

    content_tag :span, t("factures.payment_statuses.#{facture.payment_status}"), class: badge_class
  end

  def description = facture.description
  def created_at = I18n.l(facture.created_at, format: :short)
  def date = I18n.l(facture.created_at, format: :short)
  def dossier = facture.dossier.name
  def dossier_url = dossier_facture_path(facture.dossier, facture)

  def numero
    if facture.achived?
      content_tag :span, class: "text-gray-800 font-mono inline-block mx-2 font-thin" do
        "#{at(facture, :numero_abbreviated)} #{facture.screen_number}"
      end
    end
  end

  def convention
    facture.convention.present? ? k(facture.convention).amount_with_date : "--"
  end
end