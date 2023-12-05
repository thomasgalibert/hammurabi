FactoryBot.define do
  factory :facture do
    date { Date.today }
    date_fin_validite { Date.today + 30.days }
    state { :draft }
    conditions_paiement { "Paiement à réception de la facture" }
    conditions_generales { "Conditions générales de vente" }
    association :user, factory: :user
    association :dossier, factory: :dossier
    association :contact, factory: :contact
    association :emetteur, factory: :user
  end
end