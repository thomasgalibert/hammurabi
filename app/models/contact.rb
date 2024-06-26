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
# t.date "birthday"
# t.string "nationality"
# t.string "job"
# t.string "bar_name"
# t.string "mailbox_number"
# == Schema end

class Contact < ApplicationRecord
  belongs_to :user
  has_person_name
  has_many :dossier_contacts, dependent: :destroy
  has_many :dossiers, through: :dossier_contacts
  has_many :factures
  has_many :asks, dependent: :destroy
  has_many :document_share_links, dependent: :destroy
  has_many :dossier_share_links, dependent: :destroy

  KINDS = ["customer", "adversary", "adversary_attorney", "witness", "partner", "other"]

  scope :customers, -> { where(kind: "customer") }

  validates :kind, presence: true
  validates :kind, inclusion: { in: KINDS }
  validates :address, :zip_code, :city, :country, presence: true

  # Validates last_name and first_name or company_name
  validates :last_name, :first_name, presence: true, if: -> { company_name.blank? }
  validates :company_name, presence: true, if: -> { last_name.blank? && first_name.blank? }

  def name_with_company
    if self.company_name.present? && self.last_name.blank?
      self.company_name
    else
      self.last_name + " " + self.first_name
    end
  end

  def is_main?
    DossierContact.find_by(contact_id: self.id).is_main
  end

  def is_main_for?(dossier)
    DossierContact.find_by(contact_id: self.id, dossier_id: dossier.id).is_main
  end

  def self.ransackable_attributes(auth_object = nil)
    ["company_name", "last_name"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def birthday_date
    birthday.present? ? I18n.l(birthday) : "----"
  end
end
