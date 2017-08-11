# == Schema Information
#
# Table name: requisitos
#
#  id                :integer          not null, primary key
#  descripcion       :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  requisitable_id   :integer
#  requisitable_type :string
#
# Indexes
#
#  index_requisitable_type_and_id  (requisitable_type,requisitable_id)
#

FactoryGirl.define do
  factory :requisito do
    descripcion "MyString"
  end
end
