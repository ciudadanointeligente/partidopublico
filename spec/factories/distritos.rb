# == Schema Information
#
# Table name: distritos
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_distritos_on_region_id  (region_id)
#

FactoryGirl.define do
  factory :distrito do
    region nil
    nombre "MyString"
  end
end
