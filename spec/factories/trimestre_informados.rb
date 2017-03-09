# == Schema Information
#
# Table name: trimestre_informados
#
#  id         :integer          not null, primary key
#  ano        :integer
#  trimestre  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :trimestre_informado do
    ano 1
    trimestre "MyString"
  end
end
