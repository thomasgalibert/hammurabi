module Authentication
  extend ActiveSupport::Concern

  def authenticate_user!
    redirect_to root_path, alert: t('sessions.unauthenticate') unless user_signed_in?
  end

  def current_user
    Current.user ||= authenticate_user_from_session
  end

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end
  

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout(user)
    Current.user = nil
    reset_session
  end

  def check_firm_setting_is_complete
    create_firm_setting_if_not_exist
    create_facturation_setting_if_not_exist
    redirect_to settings_firm_setting_path, alert: t('firm_setting.not_complete') unless current_user.firm_setting.is_complete? && current_user.firm_setting.is_complete?
  end

  def create_firm_setting_if_not_exist
    current_user.create_firm_setting unless current_user.firm_setting.present?
  end

  def create_facturation_setting_if_not_exist
    current_user.create_facturation_setting(tva_standard: 20, first_invoice_number: 1) unless current_user.facturation_setting.present?
  end
    

end