# == Schema Information
#
# Table name: transferencias
#
#  id           :integer          not null, primary key
#  partido_id   :integer
#  fecha_datos  :date
#  numero       :string
#  razon_social :string
#  rut          :string
#  region_id    :integer
#  descripcion  :string
#  monto        :integer
#  categoria    :string
#  fecha        :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_transferencias_on_partido_id  (partido_id)
#  index_transferencias_on_region_id   (region_id)
#

FactoryGirl.define do
  factory :transferencia do
    partido nil
    fecha_datos "2016-08-10"
    numero "MyString"
    razon_social "MyString"
    rut "MyString"
    region nil
    descripcion "MyString"
    monto 1
    categoria "MyString"
    fecha "2016-08-10"
  end
end
