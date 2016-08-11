# == Schema Information
#
# Table name: ingreso_campanas
#
#  id               :integer          not null, primary key
#  partido_id       :integer
#  fecha_datos      :date
#  fecha_eleccion   :date
#  rut_candidato    :string
#  rut_donante      :string
#  nombre_donante   :string
#  fecha_documento  :date
#  tipo_documento   :string
#  numero_documento :string
#  numero_cuenta    :string
#  glosa            :string
#  monto            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_ingreso_campanas_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :ingreso_campana do
    partido nil
    fecha_datos "2016-08-10"
    fecha_eleccion "2016-08-10"
    rut_candidato "MyString"
    rut_donante "MyString"
    nombre_donante "MyString"
    fecha_documento "2016-08-10"
    tipo_documento "MyString"
    numero_documento "MyString"
    numero_cuenta "MyString"
    glosa "MyString"
    monto 1
  end
end
