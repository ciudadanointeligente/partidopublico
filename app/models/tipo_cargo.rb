# == Schema Information
#
# Table name: tipo_cargos
#
#  id         :integer          not null, primary key
#  titulo     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TipoCargo < ActiveRecord::Base
  has_many :cargos
  has_many :personas, through: :cargos
end
