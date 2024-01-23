class Slip < ApplicationRecord
  belongs_to :dossier
  broadcasts_refreshes

  default_scope { order(created_at: :asc) }

  validates :recipient, :date, presence: true
end
