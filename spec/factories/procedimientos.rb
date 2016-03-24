# == Schema Information
#
# Table name: procedimientos
#
#  id                   :integer          not null, primary key
#  descripcion          :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  procedimentable_id   :integer
#  procedimentable_type :string
#
# Indexes
#
#  index_procedimentable_type_and_id  (procedimentable_type,procedimentable_id)
#

FactoryGirl.define do
  factory :procedimiento do
    descripcion "MyString"
  end
end
