# == Schema Information
#
# Table name: estadistica_cargos
#
#  id                 :integer          not null, primary key
#  partido_id         :integer
#  item               :string
#  cantidad_mujeres   :integer
#  cantidad_hombres   :integer
#  porcentaje_mujeres :string
#  porcentaje_hombres :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  tipo_cargo         :string
#
# Indexes
#
#  index_estadistica_cargos_on_partido_id  (partido_id)
#

require 'rails_helper'

RSpec.describe EstadisticaCargo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
