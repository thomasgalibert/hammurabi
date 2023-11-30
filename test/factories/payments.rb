FactoryBot.define do
  factory :payment do
    amount_cents { 1000 }
    issued_date { Date.today }
  end
end
