# == Schema definition
# t.string "email"
# t.string "password_digest"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "last_name"
# t.string "first_name"
# t.string "firm"
# == Schema end

class User < ApplicationRecord
  has_secure_password
  has_person_name
  has_one :facturation_setting, dependent: :destroy
  has_one :firm_setting, dependent: :destroy
  has_many :dossiers, dependent: :destroy
  has_many :todos, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :conventions, dependent: :destroy
  has_many :conclusions, dependent: :destroy
  has_many :notes, :dependent => :destroy
  has_many :factures, dependent: :destroy
  has_many :lignes, through: :factures
  has_many :payments, dependent: :destroy
  has_many :asks, dependent: :destroy
  
  validates :email, presence: true
  validates :email, uniqueness: true
  normalizes :email, with: -> email { email.strip.downcase }

  validates :last_name, :first_name, :firm, presence: true

  # virtual attribute for agreement checkbox
  attr_accessor :agreement
  validates :agreement, acceptance: true, on: :create

  # Validates password width min 12 characters, 1 uppercase, 1 lowercase, 1 number, 1 special character
  validates :password, 
    format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[[:^alnum:]])/x, 
              message: 'vous devez inclure au moins une minuscule, une majuscule, un chiffre et un caractère spécial' }, 
              allow_nil: true

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  generates_token_for :email_confirmation, expires_in: 24.hours do
    email
  end

  has_secure_token :forward_email_token
  has_secure_token :accountant_token, length: 36

  def conditions_generales
    if self.facturation_setting.present? && self.facturation_setting.conditions_generales.present?
      self.facturation_setting.conditions_generales
    else
      "Conditions générales de vente"
    end
  end

  def conditions_paiement
    if self.facturation_setting.present? && self.facturation_setting.conditions_paiement.present?
      self.facturation_setting.conditions_paiement
    else
      "Paiement à réception de la facture"
    end
  end

  def first_invoice_number
    if self.facturation_setting.present? && self.facturation_setting.first_invoice_number.present?
      self.facturation_setting.first_invoice_number
    else
      1
    end
  end

  def from_email
    self.name.mentionable + "@hammurabi.software"
  end

  def communication_email
    if forward_email_token.present?
      forward_email_token + "@hammurabi.software"
    else
      regenerate_forward_email_token
      forward_email_token + "@hammurabi.software"
    end
  end

  def accountant_share_token
    if accountant_token.present?
      accountant_token
    else
      regenerate_accountant_token
      accountant_token
    end
  end
end
