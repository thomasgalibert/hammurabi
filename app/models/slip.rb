class Slip < ApplicationRecord
  belongs_to :dossier
  has_many :documents
  broadcasts_refreshes

  default_scope { order(created_at: :asc) }

  validates :recipient, :date, presence: true

  # Helpers

  def full_number
    "N° " + number.to_s
  end

  def number
    self.dossier.slips.order(:created_at).index(self) + 1
  end

  def previous_slips
    self.dossier.slips.where(created_at: ...self.created_at)
  end
end
