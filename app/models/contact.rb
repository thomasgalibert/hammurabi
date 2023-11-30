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
  has_person_name
  has_many :dossier_contacts, dependent: :destroy
  has_many :dossiers, through: :dossier_contacts

  KINDS = ["customer", "witness", "partner", "other"]

  validates :kind, presence: true
  validates :kind, inclusion: { in: KINDS }
  validates :last_name, :first_name, presence: true

  def name_with_company
    if self.company_name.present?
      "#{self.company_name} - #{self.name.full}"
    else
      self.name.full
    end
  end
end
