FactoryBot.define do
  factory :facture do
    # Ici, vous pouvez définir des attributs par défaut pour la facture si nécessaire.
    date { Date.today }
    numero { 1 }
    state { "draft" }
  end
end