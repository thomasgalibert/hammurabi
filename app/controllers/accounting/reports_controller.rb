class Accounting::ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete
  before_action :require_financial_access!
  before_action :set_period
  before_action :set_dates

  # Récapitulatif mensuel des factures
  def monthly_reports
    @invoices = team_scope(Facture).where(date: @start_date..@end_date).nodraft
    
    # Calcul des totaux
    @total_ttc = @invoices.sum(&:total_ttc_cents) / 100.0
    @total_ht = @invoices.sum(&:total_ht_cents) / 100.0
    @total_tva = @total_ttc - @total_ht

    # Ventilation par taux de TVA
    @breakdown_by_tva = {}
    @invoices.each do |invoice|
      invoice.breakdown_tva.each do |tva_rate, values|
        @breakdown_by_tva[tva_rate] ||= { base: 0, montant: 0 }
        @breakdown_by_tva[tva_rate][:base] += values[:base]
        @breakdown_by_tva[tva_rate][:montant] += values[:montant]
      end
    end

    # Convertir les centimes en euros
    @breakdown_by_tva.each do |rate, values|
      @breakdown_by_tva[rate][:base] = values[:base] / 100.0
      @breakdown_by_tva[rate][:montant] = values[:montant] / 100.0
    end

    # Récapitulatif des paiements du mois
    @payments = team_scope(Payment).where(issued_date: @start_date..@end_date)
    @total_payments = @payments.sum(&:amount_cents) / 100.0
    @total_payments_vat = @payments.sum(&:vat_evaluated_amount)

    # Ventilation des paiements par moyen de paiement
    @payments_by_means = @payments.group_by(&:mean).transform_values do |payment_group|
      payment_group.sum(&:amount_cents) / 100.0
    end

    # Récapitulatif des factures non réglées
    @unpaid_invoices = team_scope(Facture).nodraft.not_totaly_paid
    @total_unpaid_ttc = @unpaid_invoices.sum(&:balance)
    @total_unpaid_ht = @unpaid_invoices.sum { |invoice| invoice.total_ht_cents / 100.0 * (invoice.balance / invoice.total_ttc.to_f) }
    @total_unpaid_tva = @total_unpaid_ttc - @total_unpaid_ht
  end

  # Détails des factures pour la période
  def invoice_details
    @invoices = team_scope(Facture).where(date: @start_date..@end_date).nodraft.order(date: :asc)
  end

  # Détails des paiements pour la période
  def payment_details
    @payments = team_scope(Payment).where(issued_date: @start_date..@end_date).order(issued_date: :asc)
    
    # Ventilation des paiements par moyen de paiement
    @payments_by_means = @payments.group_by(&:mean).transform_values do |payment_group|
      {
        total: payment_group.sum(&:amount_cents) / 100.0,
        count: payment_group.count
      }
    end
  end

  # Liste des factures non réglées
  def unpaid_invoices
    @unpaid_invoices = team_scope(Facture).nodraft.not_totaly_paid.order(date: :asc)
  end

  private

  def set_period
    @period = params[:period].present? ? params[:period] : "month"
  end

  def set_dates
    @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : Date.today.beginning_of_month
    @end_date = set_end_date(@start_date, @period)
  end

  def set_end_date(start_date, period)
    case period
    when "week"
      start_date.end_of_week
    when "month"
      start_date.end_of_month
    when "quarter"
      start_date.end_of_quarter
    when "year"
      start_date.end_of_year
    end
  end
end