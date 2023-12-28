# SCHEMA
# t.bigint "user_id", null: false
# t.string "legal_name"
# t.text "address"
# t.string "city"
# t.string "state"
# t.string "zip_code"
# t.string "country"
# t.string "phone_number"
# t.string "email"
# t.string "business_number"
# t.string "vat_number"
# t.string "share_capital"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "bar_name"
# t.string "mailbox_number"
# t.index ["user_id"], name: "index_firm_settings_on_user_id"
# -> END SCHEMA

class FirmSetting < ApplicationRecord
  belongs_to :user

  def is_complete?
    legal_name.present? && 
    address.present? &&
    city.present? &&
    zip_code.present? &&
    country.present? &&
    phone_number.present? &&
    email.present? &&
    business_number.present? &&
    vat_number.present?
  end
end
