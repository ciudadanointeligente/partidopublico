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

require 'rails_helper'

RSpec.describe AdminLogin, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
