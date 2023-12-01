# == Schema Definition
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
# t.index ["contact_id"], name: "index_factures_on_contact_id"
# t.index ["dossier_id"], name: "index_factures_on_dossier_id"
# t.index ["emetteur_id"], name: "index_factures_on_emetteur_id"
# t.index ["user_id"], name: "index_factures_on_user_id"
# == Schema end

class Facture < ApplicationRecord
  include Facturation
  include Receipts
end