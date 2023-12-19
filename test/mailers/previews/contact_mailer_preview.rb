# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/contact_mailer/document
  def document
    ask = Ask.last
    dossier = ask.dossier
    contact =  ask.contact

    ContactMailer.with(dossier: dossier, contact: contact).document
  end

end
