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

FactoryGirl.define do
  factory :etl_run do
    start_time "2017-04-03 17:44:03"
    end_time "2017-04-03 17:44:03"
    job_name "MyString"
    results "MyText"
    input_rows 1
  end
end
