# == Schema Information
#
# Table name: marco_generals
#
#  id         :integer          not null, primary key
#  partido_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_marco_generals_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :marco_general do
    association :partido, factory: :partido1
  end
end
