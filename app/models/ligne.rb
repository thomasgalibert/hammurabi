class Ligne < ApplicationRecord
  monetize :prix_unitaire_cents, :total_ht_cents, :total_ttc_cents, :total_tva_cents, allow_nil: true

  belongs_to :facturable, polymorphic: true

  before_validation :calculer_totaux

  def calcul_ht_avec_reduction
    total_ht_sans_reduction = prix_unitaire_cents * quantite
    pourcentage_de_reduction = reduction / 100.0
    total_ht_avec_reduction = total_ht_sans_reduction * (1.0 - pourcentage_de_reduction)
  end

  def calcul_total_ttc
    pourcentage_de_tva = tva / 100.0
    total_avec_tva = calcul_ht_avec_reduction * (1.0 + pourcentage_de_tva)
  end

  def calcul_montant_tva
    pourcentage_de_tva = tva / 100.0
    montant_tva = calcul_ht_avec_reduction * pourcentage_de_tva
  end


  private

  def calculer_totaux
    self.total_ht_cents = calcul_ht_avec_reduction.round.to_i
    self.total_ttc_cents = calcul_total_ttc.round.to_i
    self.total_tva_cents = calcul_montant_tva.round.to_i
  end
end