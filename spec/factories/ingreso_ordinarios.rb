# == Schema Information
#
# Table name: ingreso_ordinarios
#
#  id          :integer          not null, primary key
#  fecha_datos :date
#  concepto    :string
#  importe     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  partido_id  :integer
#
# Indexes
#
#  index_ingreso_ordinarios_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :ingreso_ordinario do
    
  end
end
