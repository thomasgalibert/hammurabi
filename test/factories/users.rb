FactoryBot.define do
  factory :user do
    email { 'gerard@tartampion.com' }
    password { 'Azerty34500!' }
    last_name { 'Allred' }
    first_name { 'Gloria' }
    firm { 'Allred Maroko & Goldberg' }
  end
end