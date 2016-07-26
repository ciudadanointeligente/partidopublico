# == Schema Information
#
# Table name: balance_anuals
#
#  id          :integer          not null, primary key
#  partido_id  :integer
#  fecha_datos :date
#  concepto    :string
#  tipo        :string
#  importe     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_balance_anuals_on_partido_id  (partido_id)
#

require 'rails_helper'

RSpec.describe BalanceAnual, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
