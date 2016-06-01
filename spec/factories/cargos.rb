# == Schema Information
#
# Table name: cargos
#
#  id                 :integer          not null, primary key
#  persona_id         :integer
#  tipo_cargo_id      :integer
#  partido_id         :integer
#  region_id          :integer
#  comuna_id          :integer
#  circunscripcion_id :integer
#  distrito_id        :integer
#  fecha_desde        :date
#  fecha_hasta        :date
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_cargos_on_circunscripcion_id  (circunscripcion_id)
#  index_cargos_on_comuna_id           (comuna_id)
#  index_cargos_on_distrito_id         (distrito_id)
#  index_cargos_on_partido_id          (partido_id)
#  index_cargos_on_persona_id          (persona_id)
#  index_cargos_on_region_id           (region_id)
#  index_cargos_on_tipo_cargo_id       (tipo_cargo_id)
#

FactoryGirl.define do
  factory :cargo do
    persona nil
    cargo nil
    partido nil
  end
end
