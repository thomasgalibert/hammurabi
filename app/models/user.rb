# == Schema definition
# t.string "email"
# t.string "password_digest"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "last_name"
# t.string "first_name"
# t.string "firm"
# t.string "forward_email_token"
# t.string "accountant_token"
# t.string "ical_token"
# == Schema end

class User < ApplicationRecord
  has_secure_password
  has_person_name
  
  # Team relations
  belongs_to :team_owner, class_name: "User", foreign_key: "team_id", optional: true
  has_many :team_members, class_name: "User", foreign_key: "team_id", dependent: :destroy
  
  # Associations existantes
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
  has_many :slips, through: :dossiers
  
  # Constants
  ROLES = %w[owner accountant]
  
  validates :email, presence: true
  validates :email, uniqueness: true
  normalizes :email, with: -> email { email.strip.downcase }

  validates :last_name, :first_name, :firm, presence: true
  validates :role, inclusion: { in: ROLES }
  
  # Validation du team_id pour les comptables
  validates :team_id, presence: true, if: :accountant?
  validates :team_id, absence: true, if: :owner?

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
  has_secure_token :ical_token
  has_secure_token :accountant_token, length: 36

  # Override les méthodes pour utiliser les paramètres de l'owner si c'est un comptable
  def facturation_setting
    accountant? ? team_owner&.facturation_setting : super
  end
  
  def firm_setting
    accountant? ? team_owner&.firm_setting : super
  end
  
  def conditions_generales
    setting = effective_owner&.facturation_setting
    if setting.present? && setting.conditions_generales.present?
      setting.conditions_generales
    else
      "Conditions générales de vente"
    end
  end

  def conditions_paiement
    setting = effective_owner&.facturation_setting
    if setting.present? && setting.conditions_paiement.present?
      setting.conditions_paiement
    else
      "Paiement à réception de la facture"
    end
  end

  def number_of_days_before_due
    setting = effective_owner&.facturation_setting
    if setting.present? && setting.number_of_days_before_due.present?
      setting.number_of_days_before_due
    else
      15
    end
  end

  def first_invoice_number
    setting = effective_owner&.facturation_setting
    if setting.present? && setting.first_invoice_number.present?
      setting.first_invoice_number
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

  def ical_share_token
    if ical_token.present?
      ical_token
    else
      regenerate_ical_token
      ical_token
    end
  end
  
  # Méthodes de rôle
  def owner?
    role == "owner"
  end
  
  def accountant?
    role == "accountant"
  end
  
  # Récupère l'utilisateur principal (owner) pour l'équipe
  def effective_owner
    owner? ? self : team_owner
  end
  
  # Récupère tous les membres de l'équipe (owner + comptables)
  def all_team_members
    if owner?
      [self] + team_members
    else
      team_owner.all_team_members
    end
  end
  
  # IDs de tous les membres de l'équipe pour les requêtes
  def team_user_ids
    all_team_members.pluck(:id)
  end
end
