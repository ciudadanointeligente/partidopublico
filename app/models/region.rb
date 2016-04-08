# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Region < ActiveRecord::Base
    has_paper_trail
    has_and_belongs_to_many :partidos
    
    def to_s
        self.nombre
    end
end
