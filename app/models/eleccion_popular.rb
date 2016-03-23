class EleccionPopular < ActiveRecord::Base
    has_many :requisitos, as: :requisitable
    has_many :procedimientos, as: :procedimentable
    
    
    accepts_nested_attributes_for :requisitos, reject_if: proc { |attributes| attributes['descripcion'].blank? }, allow_destroy: true
    accepts_nested_attributes_for :procedimientos, reject_if: proc { |attributes| attributes['descripcion'].blank? }, allow_destroy: true
end
