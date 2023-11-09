FactoryBot.define do
  factory :event do
    title { "Titre de l'événement" }
    description { "Description de l'événement" }
    kind { "rendez-vous" }
    date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
  end
end