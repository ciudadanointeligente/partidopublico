# == Schema Information
#
# Table name: marco_internos
#
#  id         :integer          not null, primary key
#  partido_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_marco_internos_on_partido_id  (partido_id)
#

require 'rails_helper'

RSpec.describe MarcoInterno, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
