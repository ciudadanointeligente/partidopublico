# == Schema Information
#
# Table name: admin_logins
#
#  id         :integer          not null, primary key
#  fecha      :datetime
#  ip         :string
#  admin_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_admin_logins_on_admin_id  (admin_id)
#

class AdminLogin < ActiveRecord::Base
  belongs_to :admin
end
