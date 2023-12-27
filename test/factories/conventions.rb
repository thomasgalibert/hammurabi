FactoryBot.define do
  factory :convention do
    title { Faker::Lorem.sentence(word_count: 3) }
    date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    forfait_cents { Faker::Number.number(digits: 6) }
    variable { Faker::Lorem.paragraph(sentence_count: 3) }
    association :user, factory: :user
    fichier { Rack::Test::UploadedFile.new(Rails.root.join('test/fixtures/files/sample.pdf'), 'application/pdf') }
  end
end