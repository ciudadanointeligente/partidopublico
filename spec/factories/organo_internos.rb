# == Schema Information
#
# Table name: organo_internos
#
#  id              :integer          not null, primary key
#  nombre          :string
#  funciones       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  partido_id      :integer
#  contacto        :string
#  num_integrantes :integer
#
# Indexes
#
#  index_organo_internos_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :organo_interno do
    nombre "MyString"
    funciones "MyString"
    contacto "contact@contac.to"
    num_integrantes 3
  end
end
