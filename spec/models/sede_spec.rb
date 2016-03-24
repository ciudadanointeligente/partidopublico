# == Schema Information
#
# Table name: sedes
#
#  id         :integer          not null, primary key
#  region     :string
#  direccion  :string
#  contacto   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Sede, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
