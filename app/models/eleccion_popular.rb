# == Schema Information
#
# Table name: eleccion_populars
#
#  id             :integer          not null, primary key
#  fecha_eleccion :date
#  dias           :integer
#  cargo          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  partido_id     :integer
#
# Indexes
#
#  index_eleccion_populars_on_partido_id  (partido_id)
#

class EleccionPopular < ActiveRecord::Base
    has_paper_trail
    belongs_to :partido
    has_many :requisitos, as: :requisitable
    has_many :procedimientos, as: :procedimentable
    
    
    accepts_nested_attributes_for :requisitos, reject_if: proc { |attributes| attributes['descripcion'].blank? }, allow_destroy: true
    accepts_nested_attributes_for :procedimientos, reject_if: proc { |attributes| attributes['descripcion'].blank? }, allow_destroy: true
end
