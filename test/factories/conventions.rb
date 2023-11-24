FactoryBot.define do
  factory :convention do
    title { Faker::Lorem.sentence(word_count: 3) }
    date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    forfait_cents { Faker::Number.number(digits: 6) }
    variable { Faker::Lorem.paragraph(sentence_count: 3) }
  end
end