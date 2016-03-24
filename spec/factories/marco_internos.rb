# == Schema Information
#
# Table name: marco_internos
#
#  id         :integer          not null, primary key
#  partido_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_marco_internos_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :marco_interno do
    partido nil
  end
end
