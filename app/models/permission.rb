# == Schema Information
#
# Table name: permissions
#
#  id         :integer          not null, primary key
#  admin_id   :integer
#  partido_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_permissions_on_admin_id    (admin_id)
#  index_permissions_on_partido_id  (partido_id)
#

class Permission < ActiveRecord::Base
  belongs_to :admin
  belongs_to :partido

  validates_uniqueness_of :admin_id, :scope => [:partido_id]
end
