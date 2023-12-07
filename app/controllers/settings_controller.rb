class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @facturation_setting = current_user.facturation_setting || current_user.create_facturation_setting(tva_standard: 20, first_invoice_number: 1)
    @firm_setting = current_user.firm_setting || current_user.create_firm_setting
  end
end