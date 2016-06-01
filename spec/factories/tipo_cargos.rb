# == Schema Information
#
# Table name: tipo_cargos
#
#  id         :integer          not null, primary key
#  titulo     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :tipo_cargo do
    titulo "MyString"
  end
end
