# == Schema Information
#
# Table name: personas
#
#  id                    :integer          not null, primary key
#  genero                :string
#  fecha_nacimiento      :date
#  nivel_estudios        :string
#  region                :string
#  ano_inicio_militancia :integer
#  afiliado              :boolean
#  bio                   :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  foto_file_name        :string
#  foto_content_type     :string
#  foto_file_size        :integer
#  foto_updated_at       :datetime
#  nombre                :string
#  apellidos             :string
#  partido_id            :integer
#  personable_id         :integer
#  personable_type       :string
#  cargo                 :string
#  distrito              :string
#  circunscripcion       :string
#  comuna                :string
#  telefono              :string
#  email                 :string
#  fecha_desde           :date
#  fecha_hasta           :date
#  tipo                  :string
#  intereses             :string
#  patrimonio            :string
#  rut                   :string
#
# Indexes
#
#  index_personas_on_partido_id                         (partido_id)
#  index_personas_on_personable_type_and_personable_id  (personable_type,personable_id)
#

FactoryGirl.define do
  factory :persona do
    nombre "Juan de Dios"
    apellidos "Xartajerje"
    rut "1-9"
    genero "MyString"
    fecha_nacimiento "2016-03-23"
    nivel_estudios "MyString"
    region "MyString"
    ano_inicio_militancia 1
    afiliado false
    bio "MyText"
  end
end
