# == Schema definition
# t.bigint "user_id", null: false
# t.bigint "dossier_id", null: false
# t.string "title"
# t.date "date"
# t.integer "forfait_cents"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# == Schema end

class Convention < ApplicationRecord
  belongs_to :user
  belongs_to :dossier
  has_rich_text :variable
  has_one_attached :fichier

  monetize :forfait_cents

  validates :fichier, attached: true, 
            content_type: { 
              in: ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'], 
              message: "Le format du fichier doit être au format pdf ou word"}, 
            size: { 
              less_than: 10.megabytes , 
              message: "La taille du fichier ne doit pas dépasser 10 Mo" }
end
