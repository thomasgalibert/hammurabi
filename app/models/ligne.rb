class Ligne < ApplicationRecord
  monetize :prix_unitaire_cents, :total_ht_cents, :total_ttc_cents

  belongs_to :facturable, polymorphic: true

  def sous_total
    quantite * prix_unitaire.to_f * (1 - reduction / 100.0)
  end

  def total_tva
    sous_total * tva / 100.0
  end

  def total_ht
    sous_total - total_tva
  end
end