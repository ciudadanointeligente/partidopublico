# == Schema Information
#
# Table name: acuerdos
#
#  id                     :integer          not null, primary key
#  numero                 :string
#  fecha                  :date
#  tipo                   :string
#  tema                   :string
#  region                 :string
#  organo_interno_id      :integer
#  documento_file_name    :string
#  documento_content_type :string
#  documento_file_size    :integer
#  documento_updated_at   :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  partido_id             :integer
#
# Indexes
#
#  index_acuerdos_on_organo_interno_id  (organo_interno_id)
#  index_acuerdos_on_partido_id         (partido_id)
#

require 'rails_helper'

RSpec.describe Acuerdo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
