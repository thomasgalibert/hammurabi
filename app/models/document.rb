# == Schema definition
# t.bigint "user_id", null: false
# t.bigint "dossier_id", null: false
# t.string "name"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.bigint "ask_id"
# t.integer "position"
# t.index ["ask_id"], name: "index_documents_on_ask_id"
# t.index ["dossier_id"], name: "index_documents_on_dossier_id"
# t.index ["user_id"], name: "index_documents_on_user_id"
# == Schema end

class Document < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  include StampPdf
  # Associations
  belongs_to :user
  belongs_to :dossier
  belongs_to :ask, optional: true
  belongs_to :slip, optional: true, touch: true
  has_one_attached :fichier

  broadcasts_refreshes

  default_scope { order(position: :asc) }
  scope :lasts, -> (limit) { order(created_at: :desc).limit(limit) }
  scope :persisted, -> { where.not(id: nil) }

  validates :fichier, attached: true, 
            content_type: { 
              in: ['application/pdf'], 
              message: "Le format du fichier doit être au format pdf"}, 
            size: { 
              less_than: 10.megabytes , 
              message: "La taille du fichier ne doit pas dépasser 10 Mo" }

  def description
    if self.fichier.attached?
      # Get the size from the blob object and the mime type
      "#{self.fichier.blob.content_type} de #{number_to_human_size(self.fichier.blob.byte_size)}"
    else
      "---"
    end
  end

  def filename
    self.fichier.blob.filename.to_s
  end
end
