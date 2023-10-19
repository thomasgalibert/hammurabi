module Facturation
  extend ActiveSupport::Concern

  included do
    has_many :lignes, as: :facturable, dependent: :destroy
    
    # D'autres associations ou validations si nécessaire
    monetize :total_ht_cents, :total_ttc_cents, allow_nil: true
  end

  def breakdown_tva
    lignes.group_by(&:tva).transform_values do |ligne_group|
      {
        base: ligne_group.sum(&:sous_total),
        montant: ligne_group.sum(&:total_tva)
      }
    end
  end
end
