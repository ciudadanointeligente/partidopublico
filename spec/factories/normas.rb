# == Schema Information
#
# Table name: normas
#
#  id                   :integer          not null, primary key
#  fecha_datos          :date
#  tipo_marco_normativo :string
#  tipo                 :string
#  numero               :string
#  denominacion         :string
#  fecha_publicacion    :date
#  link                 :string
#  fecha_modificacion   :date
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  partido_id           :integer
#  marco_interno_id     :integer
#
# Indexes
#
#  index_normas_on_marco_interno_id  (marco_interno_id)
#  index_normas_on_partido_id        (partido_id)
#

FactoryGirl.define do
  factory :norma do
    fecha_datos "2017-01-11"
    tipo_marco_normativo "MyString"
    tipo "MyString"
    numero "MyString"
    denominacion "MyString"
    fecha_publicacion "2017-01-11"
    link "MyString"
    fecha_modificacion "2017-01-11"
  end
end
