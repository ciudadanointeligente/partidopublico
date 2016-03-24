# == Schema Information
#
# Table name: documentos
#
#  id                   :integer          not null, primary key
#  descripcion          :string
#  documentable_id      :integer
#  documentable_type    :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  archivo_file_name    :string
#  archivo_content_type :string
#  archivo_file_size    :integer
#  archivo_updated_at   :datetime
#
# Indexes
#
#  index_documentos_on_documentable_type_and_documentable_id  (documentable_type,documentable_id)
#

require 'rails_helper'

RSpec.describe Documento, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
