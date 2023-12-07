class Settings::FirmSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_firm_setting, only: [:edit, :update]

  def edit
  end

  def update
    if @firm_setting.update(firm_setting_params)
      redirect_to settings_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_firm_setting
    @firm_setting = current_user.firm_setting
  end

  def firm_setting_params
    params.require(:firm_setting).permit(
        :legal_name,
        :address,
        :city,
        :state,
        :zip_code,
        :country,
        :phone_number,
        :email,
        :business_number,
        :vat_number,
        :share_capital
      )
  end
end