# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ordinal    :string
#

class Region < ActiveRecord::Base
    # has_paper_trail
    has_and_belongs_to_many :partidos
    has_many :provincias
    has_many :comunas, through: :provincias
    has_many :distritos
    has_many :circunscripcions
    has_many :afiliacions

    def to_s
        self.nombre
    end
end
