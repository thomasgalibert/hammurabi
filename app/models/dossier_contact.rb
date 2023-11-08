# == Schema Definition
# t.bigint "dossier_id", null: false
# t.bigint "contact_id", null: false
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["contact_id"], name: "index_dossier_contacts_on_contact_id"
# t.index ["dossier_id"], name: "index_dossier_contacts_on_dossier_id"
# == Schema end

class DossierContact < ApplicationRecord
  belongs_to :dossier
  belongs_to :contact
end
