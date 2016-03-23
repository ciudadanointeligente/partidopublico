class MarcoInterno < ActiveRecord::Base
    belongs_to :partido
    has_many :documentos, as: :documentable
    
    accepts_nested_attributes_for :documentos, reject_if: proc { |attributes| attributes['archivo'].blank? }, allow_destroy: true
end
