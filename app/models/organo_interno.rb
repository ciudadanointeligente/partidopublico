# == Schema Information
#
# Table name: organo_internos
#
#  id         :integer          not null, primary key
#  nombre     :string
#  funciones  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  partido_id :integer
#

class OrganoInterno < ActiveRecord::Base
    belongs_to :partido
    has_many :personas, as: :personable
    
    accepts_nested_attributes_for :personas, reject_if: proc { |attributes| attributes['apellidos'].blank? }, allow_destroy: true
end
