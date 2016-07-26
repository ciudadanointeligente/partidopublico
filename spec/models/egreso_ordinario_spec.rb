# == Schema Information
#
# Table name: egreso_ordinarios
#
#  id          :integer          not null, primary key
#  partido_id  :integer
#  fecha_datos :date
#  concepto    :string
#  privado     :integer
#  publico     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_egreso_ordinarios_on_partido_id  (partido_id)
#

require 'rails_helper'

RSpec.describe EgresoOrdinario, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
