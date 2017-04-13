# == Schema Information
#
# Table name: ingreso_campanas
#
#  id               :integer          not null, primary key
#  partido_id       :integer
#  fecha_datos      :date
#  fecha_eleccion   :date
#  rut_candidato    :string
#  rut_donante      :string
#  nombre_donante   :string
#  fecha_documento  :date
#  tipo_documento   :string
#  numero_documento :string
#  numero_cuenta    :string
#  glosa            :string
#  monto            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tipo_aporte      :string
#
# Indexes
#
#  index_ingreso_campanas_on_partido_id  (partido_id)
#

require 'rails_helper'

RSpec.describe IngresoCampana, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
