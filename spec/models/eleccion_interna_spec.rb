# == Schema Information
#
# Table name: eleccion_internas
#
#  id                       :integer          not null, primary key
#  organo_interno_id        :integer
#  fecha_eleccion           :date
#  fecha_limite_inscripcion :date
#  cargo                    :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_eleccion_internas_on_organo_interno_id  (organo_interno_id)
#

require 'rails_helper'

RSpec.describe EleccionInterna, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
