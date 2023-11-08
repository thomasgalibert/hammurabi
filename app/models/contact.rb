# == Schema definition
# t.bigint "user_id", null: false
# t.string "kind"
# t.string "last_name"
# t.string "first_name"
# t.string "company_name"
# t.string "business_number"
# t.string "vat_number"
# t.string "email"
# t.string "phone"
# t.text "address"
# t.string "zip_code"
# t.string "city"
# t.string "country"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.boolean "main", default: false
# t.index ["user_id"], name: "index_contacts_on_user_id"
# == Schema end

class Contact < ApplicationRecord
  belongs_to :user
end
