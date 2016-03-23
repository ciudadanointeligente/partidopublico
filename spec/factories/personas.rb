FactoryGirl.define do
  factory :persona do
    genero "MyString"
    fecha_nacimiento "2016-03-23"
    nivel_estudios "MyString"
    region "MyString"
    ano_inicio_militancia 1
    afiliado false
    bio "MyText"
  end
end
