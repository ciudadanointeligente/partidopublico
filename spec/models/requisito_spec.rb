# == Schema Information
#
# Table name: requisitos
#
#  id                :integer          not null, primary key
#  descripcion       :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  requisitable_id   :integer
#  requisitable_type :string
#
# Indexes
#
#  index_requisitable_type_and_id  (requisitable_type,requisitable_id)
#

require 'rails_helper'

RSpec.describe Requisito, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
