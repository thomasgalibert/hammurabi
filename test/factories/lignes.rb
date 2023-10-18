FactoryBot.define do
  factory :ligne do
    description { "Description du produit" }
    quantite { 1 }
    prix_unitaire_cents { 1000 } # 10.00 dans la devise choisie (supposons EUR)
    facture

    trait :tva_standard do
      tva_taux { 20 } # TVA à 20%
    end

    trait :tva_reduite do
      tva_taux { 10 } # TVA à 10%
    end

    trait :avec_reduction do
      reduction { 10 } # 10% de réduction
    end
  end
end