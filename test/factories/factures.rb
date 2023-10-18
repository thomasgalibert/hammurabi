FactoryBot.define do
  factory :facture do
    # Ici, vous pouvez définir des attributs par défaut pour la facture si nécessaire.
    after(:create) do |facture|
      create_list(:ligne, 3, facture: facture)
    end
  end
end