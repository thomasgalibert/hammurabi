class DossierContact < ApplicationRecord
  belongs_to :dossier
  belongs_to :contact
end
