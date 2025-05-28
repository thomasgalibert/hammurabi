class Dashboard::FacturesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete
  before_action :set_period
  before_action :set_dates

  def index
    @factures = team_scope(Facture).where(date: @start_date..@end_date)
    @payments = team_scope(Payment).where(issued_date: @start_date..@end_date)
    @dossiers = team_scope(Dossier).where(created_at: @start_date..@end_date)
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