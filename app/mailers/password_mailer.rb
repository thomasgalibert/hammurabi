class PasswordMailer < ApplicationMailer
  def password_reset
    user = params[:user]
    @token = params[:token]

    mail to: "#{user.first_name} #{user.last_name} <#{user.email}>",
      subject: t('password_mailer.password_reset.subject')
  end
end
