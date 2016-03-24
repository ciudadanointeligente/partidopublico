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

class Requisito < ActiveRecord::Base
    belongs_to :requisitable, polymorphic: true
end
