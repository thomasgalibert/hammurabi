class DossierShareLink < ApplicationRecord
  belongs_to :contact
  belongs_to :dossier
  has_secure_token length: 36
end
