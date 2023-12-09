class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_facture

  def index
    @payments = @facture.payments
  end

  def new
    @payment = current_user.payments.new(issued_date: Date.today, facture: @facture)
  end

  def create
    @payment = current_user.payments.new(payment_params)
    if @payment.save
      redirect_to dossier_facture_path(@facture.dossier, @facture)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_facture
    @facture = current_user.factures.find(params[:facture_id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :issued_date, :facture_id)
  end
end