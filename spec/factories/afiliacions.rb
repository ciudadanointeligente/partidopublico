# == Schema Information
#
# Table name: afiliacions
#
#  id             :integer          not null, primary key
#  hombres        :integer
#  mujeres        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  partido_id     :integer
#  region_id      :integer
#  fecha_datos    :date
#  ano_nacimiento :integer
#  otros          :integer
#
# Indexes
#
#  index_afiliacions_on_partido_id  (partido_id)
#  index_afiliacions_on_region_id   (region_id)
#

FactoryGirl.define do
  factory :afiliacion do
    region nil
    hombres 1
    mujeres 1
    rangos "MyString"
  end
end
