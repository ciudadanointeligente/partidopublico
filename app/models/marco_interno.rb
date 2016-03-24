# == Schema Information
#
# Table name: marco_internos
#
#  id         :integer          not null, primary key
#  partido_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_marco_internos_on_partido_id  (partido_id)
#

class MarcoInterno < ActiveRecord::Base
    belongs_to :partido
    has_many :documentos, as: :documentable
    
    accepts_nested_attributes_for :documentos, reject_if: proc { |attributes| attributes['archivo'].blank? }, allow_destroy: true
end
