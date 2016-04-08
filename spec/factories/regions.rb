# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :region do
    nombre "MyString"
  end
end
