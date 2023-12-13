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
  def main_dossier_contact
    self.dossier_contacts.find_by(is_main: true)
  end

  def contact_principal
    main_dossier_contact.present? ? main_dossier_contact.contact : nil
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
  
  before_save :update_viewed_at, :create_reference
  before_validation :update_state_pending_if_nil

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

  def create_reference
    ref_string = SecureRandom.hex(4).upcase
    date_prefix = Date.today.strftime("%Y%m")
    self.reference = "#{date_prefix}-#{ref_string}" if self.reference.blank?
  end

  def update_state_pending_if_nil
    self.state = 'pending' if self.state.blank?
  end

  
end
