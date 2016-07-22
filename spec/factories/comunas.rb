# == Schema Information
#
# Table name: comunas
#
#  id           :integer          not null, primary key
#  provincia_id :integer
#  nombre       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_comunas_on_provincia_id  (provincia_id)
#

FactoryGirl.define do
  factory :comuna do
    nombre "MyString"
  end
end
