# == Schema Information
#
# Table name: leys
#
#  id               :integer          not null, primary key
#  numero           :string
#  nombre           :string
#  enlace           :string
#  tags             :string
#  resumen          :string
#  marco_general_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_leys_on_marco_general_id  (marco_general_id)
#

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
