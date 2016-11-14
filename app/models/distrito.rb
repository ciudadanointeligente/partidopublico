# == Schema Information
#
# Table name: distritos
#
#  id                 :integer          not null, primary key
#  circunscripcion_id :integer
#  nombre             :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_distritos_on_circunscripcion_id  (circunscripcion_id)
#

class Distrito < ActiveRecord::Base
  belongs_to :circunscripcion

    def to_s
        "D-" + self.nombre
    end
end
