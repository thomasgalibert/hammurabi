FactoryBot.define do
  factory :dossier do
    name { "Kramer contre Kramer" }
    state { :pending }
    description { "Un couple qui se déchire" }
    category { "Famille" }
    court { "Tribunal de Paris" }
  end
end