# == Schema Information
#
# Table name: circunscripcions
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_circunscripcions_on_region_id  (region_id)
#

class Circunscripcion < ActiveRecord::Base
  belongs_to :region
end
