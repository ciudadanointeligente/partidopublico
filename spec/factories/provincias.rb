# == Schema Information
#
# Table name: provincias
#
#  id         :integer          not null, primary key
#  nombre     :string
#  region_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_provincias_on_region_id  (region_id)
#

FactoryGirl.define do
  factory :provincia do
    nombre "MyString"
    region nil
  end
end
