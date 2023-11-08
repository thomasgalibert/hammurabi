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
  has_many :dossiers, dependent: :destroy
  has_many :todos, dependent: :destroy
  has_many :documents, dependent: :destroy

  validates :email, presence: true
  validates :email, uniqueness: true
  normalizes :email, with: -> email { email.strip.downcase }

  validates :last_name, :first_name, :firm, presence: true

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
end
