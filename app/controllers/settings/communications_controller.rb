class Settings::CommunicationsController < ApplicationController
  before_action :authenticate_user!

  def show
    
  end

  def regenerate_accountant_token
    current_user.regenerate_accountant_token
    redirect_to settings_communication_path, 
    notice: t('firm_setting.flash.accountant_link_renewed')
  end

end