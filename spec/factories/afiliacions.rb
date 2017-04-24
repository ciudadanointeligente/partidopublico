# == Schema Information
#
# Table name: afiliacions
#
#  id                  :integer          not null, primary key
#  hombres             :integer
#  mujeres             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  partido_id          :integer
#  region_id           :integer
#  fecha_datos         :date
#  ano_nacimiento      :integer
#  otros               :integer
#  trimestre_informado :string
#
# Indexes
#
#  index_afiliacions_on_partido_id  (partido_id)
#  index_afiliacions_on_region_id   (region_id)
#

FactoryGirl.define do
  factory :afiliacion do
    hombres 10
    mujeres 20
    fecha_datos "2016-01-01"
    ano_nacimiento 1981
    otros 0
  end
end
