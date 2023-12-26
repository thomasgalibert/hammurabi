class Sharing::InvoicesController < ApplicationController
  before_action :check_accountant_token
  before_action :set_period
  before_action :set_dates
  before_action :set_facture, only: [:show]

  def index
    @factures = @user.factures.where(date: @start_date..@end_date).order(date: :desc)
    @payments = @user.payments.where(issued_date: @start_date..@end_date)
    @dossiers = @user.dossiers.where(created_at: @start_date..@end_date)
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = FacturePdf.new(@facture)
        send_data pdf.render, filename: "facture_#{@user.name.mentionable}_#{@facture.screen_number}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  private

  def check_accountant_token
    @user = User.find_by(accountant_token: params[:token])
    if @user.nil?
      flash[:alert] = t('asks.flash.link_invalid')
      redirect_to root_path
    end
  end

  def set_facture
    @facture = @user.factures.find(params[:id])
  end

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