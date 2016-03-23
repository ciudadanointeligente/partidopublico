class OrganoInterno < ActiveRecord::Base
    belongs_to :partido
    has_many :personas, as: :personable
    
    accepts_nested_attributes_for :personas, reject_if: proc { |attributes| attributes['apellidos'].blank? }, allow_destroy: true
end
