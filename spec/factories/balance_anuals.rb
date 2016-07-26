# == Schema Information
#
# Table name: balance_anuals
#
#  id          :integer          not null, primary key
#  partido_id  :integer
#  fecha_datos :date
#  concepto    :string
#  tipo        :string
#  importe     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_balance_anuals_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :balance_anual do
    partido nil
    fecha_datos "2016-07-26"
    concepto "MyString"
    tipo "MyString"
    importe ""
  end
end
