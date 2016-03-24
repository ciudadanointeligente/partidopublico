# == Schema Information
#
# Table name: eleccion_internas
#
#  id                       :integer          not null, primary key
#  organo_interno_id        :integer
#  fecha_eleccion           :date
#  fecha_limite_inscripcion :date
#  cargo                    :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_eleccion_internas_on_organo_interno_id  (organo_interno_id)
#

FactoryGirl.define do
  factory :eleccion_interna do
    organo_interno nil
    fecha_eleccion "2016-03-23"
    fecha_limite_inscripcion "2016-03-23"
    cargo "MyString"
  end
end
