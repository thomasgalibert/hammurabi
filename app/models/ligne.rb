class Ligne < ApplicationRecord
  monetize :prix_unitaire_cents, :total_ht_cents, :total_ttc_cents
end