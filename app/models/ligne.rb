# == Schema definition
# t.string "description"
# t.integer "quantite"
# t.integer "prix_unitaire_cents"
# t.float "tva"
# t.integer "total_ht_cents"
# t.integer "total_ttc_cents"
# t.string "facturable_type", null: false
# t.bigint "facturable_id", null: false
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.float "reduction"
# t.integer "total_tva_cents"
# t.integer "row_order"
# t.index ["facturable_type", "facturable_id"], name: "index_lignes_on_facturable"
# == Schema end

class Ligne < ApplicationRecord
  monetize :prix_unitaire_cents, allow_nil: false
  monetize :total_ht_cents, :total_ttc_cents, :total_tva_cents, allow_nil: true

  UNITS = %w(forfait hour)

  validates :unit, inclusion: { in: UNITS }, allow_nil: false
  validates :description, presence: true
  validates :quantite, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :tva, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :reduction, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  belongs_to :facturable, polymorphic: true

  before_validation :calculer_totaux
  after_save :update_facture_totaux
  after_destroy :update_facture_totaux

  scope :saved, -> { where.not(id: nil) }

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

  def update_facture_totaux
    facturable.save
  end
end