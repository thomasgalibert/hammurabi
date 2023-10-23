class PasswordMailer < ApplicationMailer
  def password_reset
    mail to: params[:user].email, 
      subject: t('password_mailer.password_reset.subject')
  end
end
