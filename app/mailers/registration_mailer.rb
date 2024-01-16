class RegistrationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.registration_mailer.welcome.subject
  #
  def welcome
    @user = params[:user]
    subject = I18n.t('registration_mailer.subject') +
              I18n.t('activerecord.attributes.user.honorific') + " " +
              @user.name.full

    mail to: "#{@user.first_name} #{@user.last_name} <#{@user.email}>", subject: subject
  end
end
