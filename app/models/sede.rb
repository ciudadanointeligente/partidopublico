# == Schema Information
#
# Table name: sedes
#
#  id         :integer          not null, primary key
#  region     :string
#  direccion  :string
#  contacto   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  partido_id :integer
#
# Indexes
#
#  index_sedes_on_partido_id  (partido_id)
#

class Sede < ActiveRecord::Base
    has_paper_trail
    belongs_to :partido
        
    validates_presence_of :direccion
        
end
