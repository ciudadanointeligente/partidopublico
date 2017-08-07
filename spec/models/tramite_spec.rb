# == Schema Information
#
# Table name: tramites
#
#  id                     :integer          not null, primary key
#  nombre                 :string
#  descripcion            :string
#  persona_id             :integer
#  documento_file_name    :string
#  documento_content_type :string
#  documento_file_size    :integer
#  documento_updated_at   :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  partido_id             :integer
#  procedimiento          :string
#  requisito              :string
#  link_informacion       :string
#
# Indexes
#
#  index_tramites_on_partido_id  (partido_id)
#  index_tramites_on_persona_id  (persona_id)
#

require 'rails_helper'

RSpec.describe Tramite, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
