module Facturation
  extend ActiveSupport::Concern

  included do
    has_many :lignes, as: :facturable, dependent: :destroy
    accepts_nested_attributes_for :lignes, reject_if: proc { |attributes| attributes['quantity'].blank? }, allow_destroy: true
    
    monetize :total_ht_cents, :total_ttc_cents, allow_nil: true
    before_validation :definir_numero, :verifier_si_modifiable
    before_save :calculer_totaux
    validate :date_posterieure_a_la_derniere_facture, on: :create
    scope :nodraft, -> { where.not(state: "draft") }
  end

  def calculer_totaux
    self.total_ht_cents = lignes.sum(&:total_ht_cents)
    self.total_ttc_cents = lignes.sum(&:total_ttc_cents)
  end

  def breakdown_tva
    lignes.group_by(&:tva).transform_values do |ligne_group|
      {
        base: ligne_group.sum(&:total_ht_cents),
        montant: ligne_group.sum(&:total_tva_cents)
      }
    end
  end

  def date_posterieure_a_la_derniere_facture
    derniere_facture = self.class.order(date: :desc).first
    if derniere_facture && date < derniere_facture.date
      errors.add(:date, "doit être postérieure à la date de la dernière pièce (#{derniere_facture.date}).")
    end
  end

  def definir_numero
    if state != "draft"
      derniere_facture = self.class.nodraft.order(created_at: :desc).first
      self.numero = derniere_facture ? derniere_facture.numero + 1 : 1
    end
  end

  def verouiller
    update(state: "achived", locked: true)
  end 

  def verifier_si_modifiable
    if achived? && locked?
      errors.add(:base, "Cette facture est verrouillée et ne peut plus être modifiée.")
    end
  end

end
