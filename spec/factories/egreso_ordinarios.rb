# == Schema Information
#
# Table name: egreso_ordinarios
#
#  id          :integer          not null, primary key
#  partido_id  :integer
#  fecha_datos :date
#  concepto    :string
#  privado     :integer
#  publico     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_egreso_ordinarios_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :egreso_ordinario do
    partido nil
    fecha_datos "2016-07-25"
    concepto "MyString"
    privado 1
    publico 1
  end
end
