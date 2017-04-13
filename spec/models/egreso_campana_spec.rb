# == Schema Information
#
# Table name: egreso_campanas
#
#  id               :integer          not null, primary key
#  partido_id       :integer
#  fecha_datos      :date
#  fecha_eleccion   :date
#  rut_candidato    :string
#  rut_proveedor    :string
#  nombre_proveedor :string
#  fecha_documento  :date
#  tipo_documento   :string
#  numero_documento :string
#  numero_cuenta    :string
#  p_o_c            :string
#  glosa            :string
#  monto            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tipo_campana     :string
#  item             :string
#  estado           :string
#
# Indexes
#
#  index_egreso_campanas_on_partido_id  (partido_id)
#

require 'rails_helper'

RSpec.describe EgresoCampana, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
