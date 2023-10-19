module Facturation
  extend ActiveSupport::Concern

  included do
    has_many :lignes, as: :facturable, dependent: :destroy
    
    # D'autres associations ou validations si nécessaire
  end

  def total_ht
    lignes.sum(&:sous_total)
  end

  def total_tva
    lignes.sum(&:total_tva)
  end

  def total_ttc
    total_ht + total_tva
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
