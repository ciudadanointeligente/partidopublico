# == Schema Information
#
# Table name: comunas
#
#  id           :integer          not null, primary key
#  provincia_id :integer
#  nombre       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_comunas_on_provincia_id  (provincia_id)
#

require 'rails_helper'

RSpec.describe Comuna, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
