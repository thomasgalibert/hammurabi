class Dossier < ApplicationRecord
  belongs_to :user
  has_many :dossier_contacts
  has_many :contacts, through: :dossier_contacts
end
