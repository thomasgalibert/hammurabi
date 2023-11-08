# == Schema Definition
# t.integer "total_ht_cents"
# t.integer "total_ttc_cents"
# t.date "date"
# t.integer "numero"
# t.string "state"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "locked", default: false
# t.bigint "emetteur_id", null: false
# t.bigint "dossier_id", null: false
# t.bigint "contact_id", null: false
# t.date "date_fin_validite"
# t.index ["contact_id"], name: "index_factures_on_contact_id"
# t.index ["dossier_id"], name: "index_factures_on_dossier_id"
# t.index ["emetteur_id"], name: "index_factures_on_emetteur_id"
# == Schema end

class Facture < ApplicationRecord
  include Facturation
  include AASM

  belongs_to :emetteur, class_name: 'User'
  belongs_to :dossier
  belongs_to :contact

  has_rich_text :conditions_paiement
  has_rich_text :conditions_generales

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