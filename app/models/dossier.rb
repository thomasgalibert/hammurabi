class Dossier < ApplicationRecord
  belongs_to :user
  has_many :dossier_contacts
  has_many :contacts, through: :dossier_contacts

  # Helpers
  def contact_principal
    self.contacts.where(main: true).first
  end

  before_save :update_viewed_at

  scope :actives, -> { where.not(state: 'archived') }
  scope :last_viewed, -> (limit) { order(viewed_at: :desc).limit(limit) }

  STATES = %w[pending archived sent paid overdue]
  CATEGORIES = %w[civil business criminal family work public]

  private

  def update_viewed_at
    self.viewed_at = Time.now
  end
end
