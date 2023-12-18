# ---------------- SCHEMA ---------------------
# t.bigint "user_id", null: false
# t.bigint "dossier_id", null: false
# t.bigint "contact_id", null: false
# t.string "name"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["contact_id"], name: "index_asks_on_contact_id"
# t.index ["dossier_id"], name: "index_asks_on_dossier_id"
# t.index ["user_id"], name: "index_asks_on_user_id"
# ---------------- END ------------------------

class Ask < ApplicationRecord
  belongs_to :user
  belongs_to :dossier
  belongs_to :contact
  has_one :document

  validates :name, presence: true

  default_scope -> { order(created_at: :asc) }
  scope :for_contact, ->(contact) { where(contact: contact) }
  scope :with_document, ->() { where.associated(:document) }
  scope :without_document, ->() { where.missing(:document) }
end
