class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_facture
  before_action :set_payment, only: [:edit, :update, :destroy]

  def index
    @payments = @facture.payments
  end

  def new
    @payment = current_user.payments.new(issued_date: Date.today, facture: @facture)
  end

  def create
    @payment = current_user.payments.new(payment_params)
    if @payment.save
      respond_to do |format|
        format.html { redirect_to dossier_facture_path(@facture.dossier, @facture), notice: t('payments.flash.created') }
        format.turbo_stream { render turbo_stream: turbo_stream.append("#{@facture.id}_payments", partial: "payments/payment", locals: { payment: @payment }) }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    
  end

  def update
    if @payment.update(payment_params)
      respond_to do |format|
        format.html { redirect_to dossier_facture_path(@facture.dossier, @facture), notice: t('payments.flash.updated') }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@payment, partial: "payments/payment", locals: { payment: @payment }) }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to dossier_facture_path(@facture.dossier, @facture) }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@payment) }
    end
  end

  private

  def set_facture
    @facture = current_user.factures.find(params[:facture_id])
  end

  def set_payment
    @payment = @facture.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :issued_date, :facture_id, :mean)
  end
end