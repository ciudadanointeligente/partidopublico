# == Schema Information
#
# Table name: eleccion_populars
#
#  id             :integer          not null, primary key
#  fecha_eleccion :date
#  dias           :integer
#  cargo          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  partido_id     :integer
#
# Indexes
#
#  index_eleccion_populars_on_partido_id  (partido_id)
#

require 'rails_helper'

RSpec.describe EleccionPopular, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
