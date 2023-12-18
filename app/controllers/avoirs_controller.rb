class AvoirsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_firm_setting_is_complete
  before_action :set_facture

  def new
    
  end

  def create
    if params[:amount].present? && params[:amount].to_i > 0
      amount_cents = params[:amount].to_i * 100
      @avoir = @facture.create_avoir(amount_cents: amount_cents)
      redirect_to dossier_facture_path(@dossier, @avoir)
    else
      redirect_to new_facture_avoir_path(@facture), alert: t('factures.avoir.flash_amount_required')
    end
  end

  private

  def set_facture
    @facture = current_user.factures.find(params[:facture_id])
    @dossier = @facture.dossier
  end
end