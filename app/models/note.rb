class Note < ApplicationRecord
  belongs_to :user
  belongs_to :dossier

  has_rich_text :content

  default_scope { order(created_at: :desc) }

  validates :content, presence: true
end
