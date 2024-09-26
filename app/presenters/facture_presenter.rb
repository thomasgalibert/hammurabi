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
      when 'refund' then "bg-indigo-50 text-indigo-700 ring-indigo-600/20"
      else "bg-gray-50 text-gray-700 ring-gray-600/20"
    end

    common_class = "inline-flex flex-shrink-0 items-center rounded-full px-1.5 py-0.5 text-xs font-medium ring-1 ring-inset"
    badge_class = "#{common_class} #{specific_class}"

    content_tag :span, t("factures.payment_statuses.#{facture.payment_status}"), class: badge_class
  end

  def description = truncate(facture.description.to_plain_text)
  def created_at = I18n.l(facture.created_at, format: :short)
  def date = I18n.l(facture.date)
  def dossier = facture.dossier.name
  def total_ttc = content_tag(:span, number_to_currency(facture.total_ttc), class: "font-mono")
  def dossier_url = dossier_facture_path(facture.dossier, facture)
  def facture_url = dossier_facture_path(facture.dossier, facture)

  def download
    if facture.achived?
      download_url = dossier_facture_path(facture.dossier, facture, format: :pdf)
      render PrintButtonComponent.new(url: download_url)
    end
  end

  def share_download
    if facture.achived?
      token = facture.user.accountant_share_token
      download_url = sharing_invoice_path(facture, token: token, format: :pdf)
      render PrintButtonComponent.new(url: download_url)
    end
  end

  def numero
    if facture.achived?
      content_tag :span, class: "text-gray-800 font-mono inline-block mx-2 font-thin" do
        "#{at(facture, :numero_abbreviated)} #{facture.screen_number}"
      end
    end
  end

  def balance
    class_balance = case facture.payment_status
      when 'unpaid' then "text-rose-600"
      when 'partial' then "text-orange-600"
      when 'paid' then "text-emerald-600"
      when 'refund' then "text-indigo-600"
      else "text-gray-600"
    end

    content_tag :span, class: ["text-xs", class_balance].join(" ") do
      number_to_currency facture.balance
    end
  end

  def payments
    content_tag :span, class: "text-xs" do
      facture.payments.map do |payment|
        k(payment).amount_with_date
      end.join(", ").html_safe
    end
  end

  def convention
    facture.convention.present? ? k(facture.convention).amount_with_date : "--"
  end
end