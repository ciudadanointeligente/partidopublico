# == Schema Information
#
# Table name: distritos
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_distritos_on_region_id  (region_id)
#

require 'rails_helper'

RSpec.describe Distrito, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
