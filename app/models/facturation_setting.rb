# SCHEMA
# t.bigint "user_id", null: false
# t.decimal "tva_standard", precision: 10
# t.integer "first_invoice_number"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "default_payment_link"
# t.index ["user_id"], name: "index_facturation_settings_on_user_id"
# -> END SCHEMA


class FacturationSetting < ApplicationRecord
  belongs_to :user
  has_rich_text :conditions_generales
  has_rich_text :conditions_paiement
end
