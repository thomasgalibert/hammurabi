# ------------- SCHEMA DEFINITION -----------------
# t.integer "total_ht_cents"
# t.integer "total_ttc_cents"
# t.date "date"
# t.integer "numero"
# t.string "state"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.bigint "emetteur_id", null: false
# t.bigint "dossier_id", null: false
# t.bigint "contact_id", null: false
# t.date "date_fin_validite"
# t.bigint "user_id", null: false
# t.string "payment_status"
# t.string "backup_number"
# t.string "currency"
# t.string "order_reference"
# t.bigint "convention_id"
# t.boolean "is_refund", default: false
# t.index ["contact_id"], name: "index_factures_on_contact_id"
# t.index ["convention_id"], name: "index_factures_on_convention_id"
# t.index ["dossier_id"], name: "index_factures_on_dossier_id"
# t.index ["emetteur_id"], name: "index_factures_on_emetteur_id"
# t.index ["user_id"], name: "index_factures_on_user_id"
# ------------- END SCHEMA -------------

class Facture < ApplicationRecord
  include Facturation
  include Receipts
  include RefundSystem
  belongs_to :convention, optional: true
end