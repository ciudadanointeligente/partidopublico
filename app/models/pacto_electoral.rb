# == Schema Information
#
# Table name: pacto_electorals
#
#  id           :integer          not null, primary key
#  ano_eleccion :integer
#  nombre_pacto :string
#  descripcion  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  partido_id   :integer
#  tipo         :string
#
# Indexes
#
#  index_pacto_electorals_on_partido_id  (partido_id)
#

class PactoElectoral < ActiveRecord::Base
  has_paper_trail
  belongs_to :partido
  has_and_belongs_to_many :trimestre_informados
  # has_and_belongs_to_many :partidos, :uniq => true
end
