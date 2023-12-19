class UserPresenter < Keynote::Presenter
  presents :user

  def email_signature
    user.firm_setting.legal_name + " \n" +
    user.firm_setting.address + "\n" +
    user.firm_setting.zip_code + " " + user.firm_setting.city + "\n" +
    user.firm_setting.phone_number + "\n" + user.firm_setting.email
  end
end