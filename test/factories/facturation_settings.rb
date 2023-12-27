FactoryBot.define do
  factory :facturation_setting do
    tva_standard { 20 }
    conditions_paiement { "Paiement à réception" }
    conditions_generales { "Conditions générales" }
    first_invoice_number { 1 }
    default_payment_link { "https://www.stripe.com" }
    association :user, factory: :user
    logo { Rack::Test::UploadedFile.new(Rails.root.join('test/fixtures/files/logo.jpg'), 'image/jpeg') }
  end
end