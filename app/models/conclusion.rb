# ------------------- SCHEMA INFORMATION --------------------
# t.bigint "user_id", null: false
# t.bigint "dossier_id", null: false
# t.date "date"
# t.string "name"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["dossier_id"], name: "index_conclusions_on_dossier_id"
# t.index ["user_id"], name: "index_conclusions_on_user_id"
# ------------------------------------------------------------

class Conclusion < ApplicationRecord
  belongs_to :user
  belongs_to :dossier
  has_one_attached :fichier

  validates :name, presence: true

  validates :fichier, attached: true, 
            content_type: { 
              in: ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'], 
              message: "Le format du fichier doit être au format pdf ou word"}, 
            size: { 
              less_than: 10.megabytes , 
              message: "La taille du fichier ne doit pas dépasser 10 Mo" }
end
