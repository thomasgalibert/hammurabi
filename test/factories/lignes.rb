FactoryBot.define do

  factory :ligne do
    description { "Description du produit" }
    quantite { 1 }
    prix_unitaire_cents { 1000 } # 10.00 dans la devise choisie (supposons EUR)
    reduction { 0 }

    trait :tva_standard do
      tva { 20 } # TVA à 20%
    end

    trait :tva_reduite do
      tva { 10 } # TVA à 10%
    end

    trait :avec_reduction do
      reduction { 10 } # 10% de réduction
    end

    trait :for_facture do
      association :facturable, factory: :facture
    end
  end
end