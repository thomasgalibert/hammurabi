class DossierShareLink < ApplicationRecord
  belongs_to :contact
  belongs_to :dossier
end
