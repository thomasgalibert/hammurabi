# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Seed user
user = User.create(
  email: 'test@gmail.com',
  password: 'Azerty34500!',
  last_name: 'Allred',
  first_name: 'Gloria',
  firm: 'Allred Maroko & Goldberg',
)

# Seeds 100 dossier records

states = Dossier::STATES
categories = Dossier::CATEGORIES
courts = ["TGI de Paris", "TGI Marseille", "Conseil des prud'hommes de Perpignan", "Tribunal de commerce de Lyon"]

100.times do
  dossier = Dossier.create(
    name: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 10),
    state: states.sample,
    category: categories.sample,
    court: courts.sample,
    user: user
  )

  dossier.contacts.create(
    user: user,
    kind: "customer",
    last_name: Faker::Name.last_name,
    first_name: Faker::Name.first_name,
    company_name: Faker::Company.name,
    business_number: Faker::Company.french_siren_number,
    vat_number: "FR#{Faker::Company.french_siren_number}",
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.street_address,
    zip_code: Faker::Address.zip_code,
    city: Faker::Address.city,
    country: 'FR',
    main: true
  )

  dossier.contacts.create(
    user: user,
    kind: Contact::KINDS.sample,
    last_name: Faker::Name.last_name,
    first_name: Faker::Name.first_name,
    company_name: Faker::Company.name,
    business_number: Faker::Company.french_siren_number,
    vat_number: "FR#{Faker::Company.french_siren_number}",
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.street_address,
    zip_code: Faker::Address.zip_code,
    city: Faker::Address.city,
    country: 'FR',
    main: false
  )

  2.times do
    Todo.create(
      name: Faker::Lorem.sentence(word_count: 3),
      due_at: Faker::Date.between(from: 2.days.ago, to: Date.today),
      todoable: dossier,
      user: user,
      done: Faker::Boolean.boolean(true_ratio: 0.2)
    )

    Document.create(
      name: Faker::Lorem.sentence(word_count: 3),
      user: user,
      dossier: dossier
    )
  end

  3.times do
    dossier.events.create(
      user: user,
      title: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.paragraph(sentence_count: 2),
      kind: Event::KINDS.sample,
      date: Faker::Date.between(from: 30.days.ago, to: Date.today)
    )
  end
end

# Seeds 100 user records

# 100.times do
#   User.create(
#     email: Faker::Internet.email,
#     password: Faker::Internet.password(min_length: 6, max_length: 12)
#   )
# end

# Seeds 100 contact records

# 100.times do
#   Contact.create(
#     user_id: 1,
#     kind: Faker::Lorem.word,
#     last_name: Faker::Name.last_name,
#     first_name: Faker::Name.first_name,
#     company_name: Faker::Company.name,
#     business_number: Faker::Company.buzzword,
#     vat_number: Faker::Company.buzzword,
#     email: Faker::Internet.email,
#     phone: Faker::PhoneNumber.phone_number,
#     address: Faker::Address.street_address,
#     zip_code: Faker::Address.zip_code
#   )
# end

# Seeds 100 invoice records

# 100.times do
#   Invoice.create(
#     user_id: 1,
#     contact_id: 1,
#     title: Faker::Lorem.sentence(word_count: 3),
#     description: Faker::Lorem.paragraph(sentence_count: 2),
#     invoice_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
#     due_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
#     amount: Faker::Number.decimal(l_digits: 2),
#     status: Faker::Lorem.word
#   )
# end

# Seeds 100 expense records

# 100.times do
#   Expense.create(
#     user_id: 1,
#     contact_id: 1,
#     title: Faker::Lorem.sentence(word_count: 3),
#     description: Faker::Lorem.paragraph(sentence_count: 2),
#     expense_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
#     amount: Faker::Number.decimal(l_digits: 2),
#     status: Faker::Lorem.word
#   )
# end

# Seeds 100 payment
