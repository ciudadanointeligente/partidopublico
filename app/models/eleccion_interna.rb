class EleccionInterna < ActiveRecord::Base
    belongs_to :organo_interno    
    has_many :requisitos, as: :requisitable
    has_many :procedimientos, as: :procedimentable
    
    accepts_nested_attributes_for :requisitos, reject_if: proc { |attributes| attributes['descripcion'].blank? }, allow_destroy: true
    accepts_nested_attributes_for :procedimientos, reject_if: proc { |attributes| attributes['descripcion'].blank? }, allow_destroy: true
end
