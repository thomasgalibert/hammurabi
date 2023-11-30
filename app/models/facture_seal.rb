# SCHEMA
# t.bigint "facture_id", null: false
# t.string "emetteur_legal_name"
# t.text "emetteur_address"
# t.string "emetteur_city"
# t.string "emetteur_zip_code"
# t.string "emetteur_country"
# t.string "emetteur_business_number"
# t.string "emetteur_vat_number"
# t.string "emetteur_share_capital"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["facture_id"], name: "index_facture_seals_on_facture_id"
# -> END SCHEMA

class FactureSeal < ApplicationRecord
  belongs_to :facture
end
