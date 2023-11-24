FactoryBot.define do
  factory :contact do
    last_name { "BERTILLON" }
    first_name { "Alphonse" }
    company_name { "Bertillon et fils" }
    business_number { "123456789" }
    vat_number { "FR123456789" }
    email { "a.bertillon@gmail.com" }
    phone { "01 23 45 67 89" }
    address { "1 rue de la Paix" }
    zip_code { "75000" }
    city { "Paris" }
    country { "France" }
    kind { "customer" }
  end
end