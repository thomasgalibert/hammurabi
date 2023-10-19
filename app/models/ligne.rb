class Ligne < ApplicationRecord
  monetize :prix_unitaire_cents, :total_ht_cents, :total_ttc_cents

  belongs_to :facturable, polymorphic: true

  def sous_total
    20
  end

  def total_tva
    10
  end

  def total_ht
    20
  end
end