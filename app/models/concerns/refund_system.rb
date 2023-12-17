module RefundSystem
  extend ActiveSupport::Concern

  def create_avoir(amount_cents:)
    return if self.draft? || amount_cents > self.total_ttc_cents

    dossier = self.dossier
    user = self.user
    contact = self.contact
    title = "#{I18n.t('factures.avoir.title')} #{self.screen_number}"
    prix_unitaire_cents = -(amount_cents) / (1 + user.facturation_setting.tva_standard / 100.0)

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
      prix_unitaire_cents: prix_unitaire_cents,
      unit: :forfait)

    avoir.complete!
    avoir
  end
end