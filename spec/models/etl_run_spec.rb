# == Schema Information
#
# Table name: etl_runs
#
#  id         :integer          not null, primary key
#  start_time :datetime
#  end_time   :datetime
#  job_name   :string
#  results    :text
#  input_rows :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe EtlRun, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
