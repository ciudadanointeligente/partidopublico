# == Schema Information
#
# Table name: participacion_entidads
#
#  id                     :integer          not null, primary key
#  entidad                :string
#  descripcion            :string
#  documento_file_name    :string
#  documento_content_type :string
#  documento_file_size    :integer
#  documento_updated_at   :datetime
#  partido_id             :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_participacion_entidads_on_partido_id  (partido_id)
#

require 'rails_helper'

RSpec.describe ParticipacionEntidad, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
