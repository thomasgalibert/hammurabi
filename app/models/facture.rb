class Facture < ApplicationRecord
  include Facturation
  include AASM

  belongs_to :emetteur, class_name: 'User'
  belongs_to :dossier

  aasm column: :state do
    state :draft, initial: true
    state :achived

    event :complete do
      transitions from: :draft, to: :achived, after: :definir_numero_et_verrouiller
    end
  end

  private

  def definir_numero_et_verrouiller
    verouiller
  end
end