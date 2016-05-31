# == Schema Information
#
# Table name: eleccion_internas
#
#  id                       :integer          not null, primary key
#  organo_interno_id        :integer
#  fecha_eleccion           :date
#  fecha_limite_inscripcion :date
#  cargo                    :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  partido_id               :integer
#
# Indexes
#
#  index_eleccion_internas_on_organo_interno_id  (organo_interno_id)
#  index_eleccion_internas_on_partido_id         (partido_id)
#

class EleccionInterna < ActiveRecord::Base
    has_paper_trail
    belongs_to :organo_interno 
    belongs_to :partido
    has_many :requisitos, as: :requisitable, dependent: :destroy
    has_many :procedimientos, as: :procedimentable, dependent: :destroy
    
    accepts_nested_attributes_for :requisitos, reject_if: proc { |attributes| attributes['descripcion'].blank? }, allow_destroy: true
    accepts_nested_attributes_for :procedimientos, reject_if: proc { |attributes| attributes['descripcion'].blank? }, allow_destroy: true
end
