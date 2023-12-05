FactoryBot.define do
  factory :todo do
    name { "MyString" }
    done { false }
    association :user
    association :todoable, factory: :dossier
  end
end