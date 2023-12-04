class Settings::FacturationSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_facturation_setting, only: [:edit, :update]

  def edit
  end

  def update
    if @facturation_setting.update(facturation_setting_params)
      redirect_to settings_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_facturation_setting
    @facturation_setting = current_user.facturation_setting
  end

  def facturation_setting_params
    params.require(:facturation_setting).permit(
      :tva_standard, 
      :first_invoice_number, 
      :default_payment_link, 
      :logo)
  end
end