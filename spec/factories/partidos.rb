# == Schema Information
#
# Table name: partidos
#
#  id                      :integer          not null, primary key
#  nombre                  :string           not null
#  sigla                   :string           not null
#  lema                    :string           not null
#  fecha_fundacion         :date
#  texto                   :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  logo_file_name          :string
#  logo_content_type       :string
#  logo_file_size          :integer
#  logo_updated_at         :datetime
#  front_logo_file_name    :string
#  front_logo_content_type :string
#  front_logo_file_size    :integer
#  front_logo_updated_at   :datetime
#  cplt_code               :string
#

FactoryGirl.define do
  factory :partido, aliases: [:partidoX] do
    nombre Faker::Team.name
    sigla Faker::Lorem.characters(5)
    lema Faker::Lorem.sentence(3, true, 4)
    fecha_fundacion Faker::Date.backward(10000)
    texto Faker::Lorem.paragraph(8)

    factory :partido1 do
        nombre Faker::Team.name
        sigla Faker::Lorem.characters(5)
        lema Faker::Lorem.sentence(3, true, 4)
        fecha_fundacion Faker::Date.backward(10000)
        texto Faker::Lorem.paragraph(8)
    end

    factory :partido2 do
        nombre Faker::Team.name
        sigla Faker::Lorem.characters(5)
        lema Faker::Lorem.sentence(3, true, 4)
        fecha_fundacion Faker::Date.backward(10000)
        texto Faker::Lorem.paragraph(8)
    end

    factory :invalid_partido do
      sigla nil
    end
  end
end
