# == Schema Information
#
# Table name: estadistica_cargos
#
#  id                 :integer          not null, primary key
#  partido_id         :integer
#  item               :string
#  cantidad_mujeres   :integer
#  cantidad_hombres   :integer
#  porcentaje_mujeres :string
#  porcentaje_hombres :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_estadistica_cargos_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :estadistica_cargo do
    
  end
end
