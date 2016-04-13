# == Schema Information
#
# Table name: distritos
#
#  id         :integer          not null, primary key
#  region_id  :integer
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_distritos_on_region_id  (region_id)
#

class Distrito < ActiveRecord::Base
  belongs_to :region
end
