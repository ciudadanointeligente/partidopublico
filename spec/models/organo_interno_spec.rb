# == Schema Information
#
# Table name: organo_internos
#
#  id         :integer          not null, primary key
#  nombre     :string
#  funciones  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  partido_id :integer
#
# Indexes
#
#  index_organo_internos_on_partido_id  (partido_id)
#

require 'rails_helper'

RSpec.describe OrganoInterno, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
