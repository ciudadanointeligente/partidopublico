# == Schema Information
#
# Table name: comunas
#
#  id           :integer          not null, primary key
#  provincia_id :integer
#  nombre       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_comunas_on_provincia_id  (provincia_id)
#

class Comuna < ActiveRecord::Base
  belongs_to :provincia
  has_many :sede, dependent: :destroy

    def to_s
        self.nombre
    end
end
