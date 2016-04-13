# == Schema Information
#
# Table name: circunscripcions
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_circunscripcions_on_region_id  (region_id)
#

FactoryGirl.define do
  factory :circunscripcion do
    region nil
    nombre "MyString"
  end
end
