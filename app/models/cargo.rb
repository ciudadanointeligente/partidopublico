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
#  organo_interno_id  :integer
#
# Indexes
#
#  index_cargos_on_circunscripcion_id  (circunscripcion_id)
#  index_cargos_on_comuna_id           (comuna_id)
#  index_cargos_on_distrito_id         (distrito_id)
#  index_cargos_on_organo_interno_id   (organo_interno_id)
#  index_cargos_on_partido_id          (partido_id)
#  index_cargos_on_persona_id          (persona_id)
#  index_cargos_on_region_id           (region_id)
#  index_cargos_on_tipo_cargo_id       (tipo_cargo_id)
#

class Cargo < ActiveRecord::Base
  # has_paper_trail
  belongs_to :persona
  belongs_to :tipo_cargo
  belongs_to :partido

  belongs_to :region
  belongs_to :comuna
  belongs_to :circunscripcion
  belongs_to :distrito
  belongs_to :organo_interno

  has_and_belongs_to_many :trimestre_informados

  def lugar
    if !self.comuna.blank? || !self.region.blank?
      return self.comuna.to_s + " - " + self.region.to_s
    elsif !self.distrito.blank? || !self.circunscripcion.blank?
      return self.distrito.to_s + " - " + self.circunscripcion.to_s
    else self.tipo_cargo.cargo_interno
      return self.organo_interno.to_s
    end
  end

end
