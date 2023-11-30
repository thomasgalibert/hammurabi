FactoryBot.define do
  factory :ligne do
    description { "Description du produit" }
    quantite { 1 }
    prix_unitaire_cents { 1000 } # 10.00 dans la devise choisie (supposons EUR)
    reduction { 0 }
    tva { 20 }
    unit { "forfait" }
    association :facturable, factory: :facture

    trait :tva_standard do
      tva { 20 }
    end

    trait :tva_reduite do
      tva { 5.5 }
    end

    trait :reduction_15 do
      reduction { 15 }
    end
  end
end