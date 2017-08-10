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
#  index_requisitos_on_requisitable_type_and_requisitable_id  (requisitable_type,requisitable_id)
#

class Requisito < ActiveRecord::Base
    # has_paper_trail
    belongs_to :requisitable, polymorphic: true
end
