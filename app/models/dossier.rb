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
  STATES = %w[pending partial unpaid paid archived]
  CATEGORIES = %w[civil business criminal family work public]

  belongs_to :user
  has_many :dossier_contacts
  has_many :contacts, through: :dossier_contacts
  has_many :todos, as: :todoable
  has_many :documents, dependent: :destroy
  has_many :events, :dependent => :destroy
  has_many :conventions, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  has_many :factures, :dependent => :destroy

  validates :name, presence: true
  validates :state, inclusion: { in: STATES }
  
  scope :actives, -> { where.not(state: 'archived') }
  scope :last_viewed, -> (limit) { order(viewed_at: :desc).limit(limit) }
  
  # Helpers
  def contact_principal
    self.contacts.where(main: true).first
  end
  
  before_save :update_viewed_at

  def update_state
    dossier_factures = self.factures.nodraft

    if dossier_factures.any?
      if dossier_factures.all? { |facture| facture.paid? }
        update(state: 'paid') 
      elsif dossier_factures.any? { |facture| facture.partial? }
        update(state: 'partial') 
      elsif dossier_factures.any? { |facture| facture.unpaid? }
        update(state: 'unpaid') 
      else
        update(state: 'unpaid') 
      end
    else
      update(state: 'pending') 
    end
  end

  private

  def update_viewed_at
    self.viewed_at = Time.now
  end

  
end
