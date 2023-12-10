module Facturation
  extend ActiveSupport::Concern

  included do
    STATES = %w(draft achived)
    monetize :total_ht_cents, :total_ttc_cents, allow_nil: true

    belongs_to :emetteur, class_name: 'User'
    belongs_to :dossier, touch: true
    belongs_to :contact
    belongs_to :user

    has_one :facture_seal, dependent: :destroy

    has_many :payments, dependent: :destroy
    has_many :lignes, as: :facturable, dependent: :destroy
    accepts_nested_attributes_for :lignes, reject_if: proc { |attributes| attributes['quantity'].blank? }, allow_destroy: true

    has_rich_text :description
    has_rich_text :conditions_paiement
    has_rich_text :conditions_generales

    validate :date_posterieure_a_la_derniere_facture, on: :create
    validates :state, inclusion: { in: STATES }

    before_validation :verifier_si_modifiable
    before_save :calculer_totaux
    before_save :set_conditions
    before_save :check_currency_exists?
    after_save :update_dossier_state

    scope :nodraft, -> { where.not(state: "draft") }
  end

  # Helpers

  def screen_number
    (numero + self.user.first_invoice_number - 1).to_s.rjust(8, "0")
  end

  def due_date
    self.date + self.user.facturation_setting.number_of_days_before_due.days
  end

  def breakdown_tva
    lignes.saved.group_by(&:tva).transform_values do |ligne_group|
      {
        base: ligne_group.sum(&:total_ht_cents),
        montant: ligne_group.sum(&:total_tva_cents)
      }
    end
  end

  def convention_number
    self.convention.present? ? I18n.l(self.convention.date) : ""
  end

  # States

  def complete!
    definir_numero
  end

  def achived?
    state == "achived"
  end

  def draft?
    state == "draft"
  end

  # Calculations

  def calculer_totaux
    self.total_ht_cents = lignes.sum(&:total_ht_cents)
    self.total_ttc_cents = lignes.sum(&:total_ttc_cents)
  end

  private

  def date_posterieure_a_la_derniere_facture
    derniere_facture = self.user.factures.order(date: :desc).first
    if derniere_facture && date < derniere_facture.date
      errors.add(:date, "doit être postérieure à la date de la dernière pièce (#{derniere_facture.date}).")
    end
  end

  def definir_numero
    if numero.blank?
      derniere_facture = self.user.factures.nodraft.order(created_at: :desc).first
      new_number = derniere_facture ? derniere_facture.numero + 1 : 1
      update(numero: new_number)
      update(backup_number: self.screen_number)
      update_attribute(:state, "achived")
      create_facture_seal_from_facture(self)
    end
  end 

  def verifier_si_modifiable
    if self.achived? && !mise_a_jour_paiement_status_uniquement?
      errors.add(:base, "Cette facture est verrouillée et ne peut plus être modifiée.")
    end
  end

  def set_conditions
    self.conditions_paiement = self.user.conditions_paiement if self.conditions_paiement.blank?
    self.conditions_generales = self.user.conditions_generales if self.conditions_generales.blank?
  end

  def create_facture_seal_from_facture(facture)
    unless facture.facture_seal.present?
      facture_seal = FactureSeal.new(facture: facture)
      facture_seal.populate_with_facture(facture)
      facture_seal.save
    end
  end

  def check_currency_exists?
    self.currency = "EUR" if self.currency.blank?
  end

  def update_dossier_state
    self.dossier.update_state
  end

  def mise_a_jour_paiement_status_uniquement?
    self.changed == ['payment_status']
  end

end
