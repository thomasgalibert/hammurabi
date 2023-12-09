class Settings::FacturationSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_facturation_setting, only: [:edit, :update, :show]

  def edit
  end

  def update
    if @facturation_setting.update(facturation_setting_params)
      redirect_to settings_facturation_setting_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    
  end

  private

  def set_facturation_setting
    @facturation_setting = current_user.facturation_setting || current_user.create_facturation_setting(tva_standard: 20, first_invoice_number: 1)
  end

  def facturation_setting_params
    params.require(:facturation_setting).permit(
      :tva_standard, 
      :first_invoice_number, 
      :default_payment_link, 
      :logo,
      :conditions_paiement
    )
  end
end