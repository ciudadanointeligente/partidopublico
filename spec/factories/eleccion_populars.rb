# == Schema Information
#
# Table name: eleccion_populars
#
#  id             :integer          not null, primary key
#  fecha_eleccion :date
#  dias           :integer
#  cargo          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :eleccion_popular do
    fecha_eleccion "2016-03-23"
    dias 1
    cargo "MyString"
  end
end
