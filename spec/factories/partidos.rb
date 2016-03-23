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