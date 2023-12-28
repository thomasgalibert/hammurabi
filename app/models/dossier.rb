# == Schema definition
# t.bigint "user_id", null: false
# t.string "name"
# t.string "state"
# t.text "description"
# t.string "category"
# t.string "court"
# t.string "rg_number"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.datetime "viewed_at"
# t.index ["user_id"], name: "index_dossiers_on_user_id"
# == Schema end

class Dossier < ApplicationRecord
  STATES = %w[pending unpaid partial paid archived]
  CATEGORIES = %w[civil business criminal family work public]

  belongs_to :user
  has_many :dossier_contacts
  has_many :contacts, through: :dossier_contacts
  has_many :todos, as: :todoable
  has_many :documents, dependent: :destroy
  has_many :events, :dependent => :destroy
  has_many :conventions, :dependent => :destroy
  has_many :conclusions, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  has_many :factures, :dependent => :destroy
  has_many :payments, through: :factures, dependent: :destroy
  has_many :asks, :dependent => :destroy
  has_many :document_share_links, dependent: :destroy
  has_many :dossier_share_links, dependent: :destroy

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

  def adversary
    self.contacts.find_by(kind: "adversary")
  end

  def adversary_attorney
    self.contacts.find_by(kind: "adversary_attorney")
  end

  def can_edit_document_submission_schedule?
    contact_principal.present? && adversary.present? && adversary_attorney.present?
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name", "state"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["contacts", "conventions", "documents", "dossier_contacts", "events", "factures", "notes", "todos", "user"]
  end
  
  before_save :update_viewed_at, :create_reference
  before_validation :update_state_pending_if_nil

  def update_state
    dossier_factures = self.factures.nodraft
    dossier_payments = self.payments

    if dossier_factures.any?
      case balance
        when dossier_factures.sum(:total_ttc_cents) then update(state: 'unpaid')
        when 0 then update(state: 'paid')
        when 1.. then update(state: 'partial')
        else update(state: 'pending')
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

  def balance
    dossier_factures = self.factures.nodraft
    dossier_payments = self.payments
    sum_factures = dossier_factures.sum(:total_ttc_cents)
    sum_payments = dossier_payments.sum(:amount_cents)
    return sum_factures - sum_payments
  end

  
end
