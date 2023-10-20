FactoryBot.define do
  factory :facture do
    date { Date.today }
    state { :draft }
  end
end