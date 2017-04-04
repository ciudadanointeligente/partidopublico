# == Schema Information
#
# Table name: transferencias
#
#  id              :integer          not null, primary key
#  partido_id      :integer
#  fecha_datos     :date
#  numero          :string
#  razon_social    :string
#  rut             :string
#  region_id       :integer
#  descripcion     :string
#  monto           :integer
#  categoria       :string
#  fecha           :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  persona_natural :string
#
# Indexes
#
#  index_transferencias_on_partido_id  (partido_id)
#  index_transferencias_on_region_id   (region_id)
#

require 'rails_helper'

RSpec.describe Transferencia, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
