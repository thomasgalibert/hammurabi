module RefundSystem
  extend ActiveSupport::Concern

  def create_avoir(amount_cents:)
    return if self.draft?

    dossier = self.dossier
    user = self.user
    contact = self.contact
    title = "#{I18n.t('factures.avoir.title')} #{self.screen_number}"

    avoir = user.factures.create!(
      description: title,
      state: "draft",
      dossier: dossier, 
      emetteur: user, 
      contact: contact,
      date: Date.today,
      payment_status: "paid",
      currency: self.currency,
      order_reference: self.order_reference,
      conditions_paiement: self.conditions_paiement,
      is_refund: true)
    
    avoir.lignes.create!(
      description: title,
      quantite: 1,
      reduction: 0,
      tva: user.facturation_setting.tva_standard,
      prix_unitaire_cents: amount_cents,
      unit: :forfait)

    avoir.complete!
    avoir
  end
end