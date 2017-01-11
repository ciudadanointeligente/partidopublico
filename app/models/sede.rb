# == Schema Information
#
# Table name: sedes
#
#  id         :integer          not null, primary key
#  direccion  :string
#  contacto   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  partido_id :integer
#  region_id  :integer
#  comuna_id  :integer
#
# Indexes
#
#  index_sedes_on_comuna_id   (comuna_id)
#  index_sedes_on_partido_id  (partido_id)
#

class Sede < ActiveRecord::Base
    # has_paper_trail
    belongs_to :partido
    belongs_to :region
    belongs_to :comuna

    validates_presence_of :direccion, :region_id, :comuna_id

end
