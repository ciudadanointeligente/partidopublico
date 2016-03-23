FactoryGirl.define do
  factory :ley do
    numero Faker::Date.backward(10000)
    nombre Faker::Lorem.characters(5)
    enlace Faker::Internet.url
    tags Faker::Hipster.words(4)
    resumen Faker::Lorem.paragraph(4)
    association :marco_general, factory: :marco_general
  end
end
