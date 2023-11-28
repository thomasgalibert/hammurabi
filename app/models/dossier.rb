# == Schema definition
# t.bigint "user_id", null: false
# t.string "name"
# t.string "state"
# t.text "description"
# t.string "category"
# t.string "court"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.datetime "viewed_at"
# t.index ["user_id"], name: "index_dossiers_on_user_id"
# == Schema end

class Dossier < ApplicationRecord
  belongs_to :user
  has_many :dossier_contacts
  has_many :contacts, through: :dossier_contacts
  has_many :todos, as: :todoable
  has_many :documents, dependent: :destroy
  has_many :events, :dependent => :destroy
  has_many :conventions, :dependent => :destroy
  has_many :notes, :dependent => :destroy

  validates :name, presence: true

  
  scope :actives, -> { where.not(state: 'archived') }
  scope :last_viewed, -> (limit) { order(viewed_at: :desc).limit(limit) }
  
  STATES = %w[pending archived sent paid overdue]
  CATEGORIES = %w[civil business criminal family work public]
  
  # Helpers
  def contact_principal
    self.contacts.where(main: true).first
  end
  
  before_save :update_viewed_at

  private

  def update_viewed_at
    self.viewed_at = Time.now
  end
end
