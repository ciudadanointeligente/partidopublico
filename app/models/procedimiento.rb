# == Schema Information
#
# Table name: procedimientos
#
#  id                   :integer          not null, primary key
#  descripcion          :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  procedimentable_id   :integer
#  procedimentable_type :string
#

class Procedimiento < ActiveRecord::Base
    belongs_to :procedimentable, polymorphic: true
end
