class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.document.subject
  #
  def document
    @dossier = params[:dossier]
    @contact = params[:contact]
    @user = @dossier.user
    subject = I18n.t('asks.emails.subject') +
              I18n.t('activerecord.attributes.user.honorific') + " " +
              @user.name.full

    mail to: @contact.email, subject: subject, from: @user.from_email
  end
end
