# == Schema Information
#
# Table name: circunscripcions
#
#  id         :integer          not null, primary key
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Circunscripcion < ActiveRecord::Base
  has_many :distritos

    def to_s
        self.nombre
    end
end
