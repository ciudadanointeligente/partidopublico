# == Schema Information
#
# Table name: circunscripcions
#
#  id         :integer          not null, primary key
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :circunscripcion do
    region nil
    nombre "MyString"
  end
end
