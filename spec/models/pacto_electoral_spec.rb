# == Schema Information
#
# Table name: pacto_electorals
#
#  id           :integer          not null, primary key
#  ano_eleccion :integer
#  nombre_pacto :string
#  descripcion  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe PactoElectoral, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
