# == Schema Information
#
# Table name: tipo_cargos
#
#  id            :integer          not null, primary key
#  titulo        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  partido_id    :integer
#  cargo_interno :boolean
#  representante :boolean
#  autoridad     :boolean
#
# Indexes
#
#  index_tipo_cargos_on_partido_id  (partido_id)
#

require 'rails_helper'

RSpec.describe TipoCargo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
