# == Schema Information
#
# Table name: sedes
#
#  id         :integer          not null, primary key
#  direccion  :string
#  contacto   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  partido_id :integer
#  region_id  :integer
#
# Indexes
#
#  index_sedes_on_partido_id  (partido_id)
#

require 'rails_helper'

RSpec.describe Sede, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
