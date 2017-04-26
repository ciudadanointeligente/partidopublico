# == Schema Information
#
# Table name: etl_runs
#
#  id          :integer          not null, primary key
#  start_time  :datetime
#  end_time    :datetime
#  job_name    :string
#  results     :text
#  input_rows  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  fecha_datos :date
#

class EtlRun < ActiveRecord::Base

  def duration
    end_time - start_time
  end

end
