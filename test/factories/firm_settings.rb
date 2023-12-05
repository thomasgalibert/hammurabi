FactoryBot.define do
  factory :firm_setting do
    legal_name { "Allred Maroko & Goldberg" }
    address { "6300 Wilshire Blvd, Suite 1500" }
    city { "Los Angeles" }
    state { "CA" }
    zip_code { "90048" }
    country { "FR" }
    phone_number { "323-653-6530" }
    email { "facturation@gmail.com " }
    business_number { "567 567 567 00022" }
    vat_number { "FR8567567567" }
    share_capital { "100000" }
    association :user, factory: :user
  end
end