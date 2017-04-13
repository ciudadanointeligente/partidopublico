# == Schema Information
#
# Table name: egreso_campanas
#
#  id               :integer          not null, primary key
#  partido_id       :integer
#  fecha_datos      :date
#  fecha_eleccion   :date
#  rut_candidato    :string
#  rut_proveedor    :string
#  nombre_proveedor :string
#  fecha_documento  :date
#  tipo_documento   :string
#  numero_documento :string
#  numero_cuenta    :string
#  p_o_c            :string
#  glosa            :string
#  monto            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tipo_campana     :string
#  item             :string
#  estado           :string
#
# Indexes
#
#  index_egreso_campanas_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :egreso_campana do
    partido nil
    fecha_datos "2016-08-10"
    fecha_eleccion "2016-08-10"
    rut_candidato "MyString"
    rut_proveedor "MyString"
    nombre "MyString"
    proveedor "MyString"
    fecha_documento "2016-08-10"
    tipo_documento "MyString"
    numero_documento "MyString"
    numero_cuenta "MyString"
    p_o_c "MyString"
    glosa "MyString"
    monto 1
  end
end
