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

  def self.max_fecha_datos
    EtlRun.maximum("fecha_datos")
  end

  def self.file_exists?(fecha, job_name)
    file = 'etl/input_files/cplt/' + fecha.strftime("%Y%m%d") + '/' + job_name + '.csv'
    # p file if File.exist?(file)
    File.exist?(file)
  end

  def self.log_file_exists?(fecha, job_name)
    file = 'etl/log/' + fecha.strftime("%Y%m%d") + '/' + job_name + '.log'
    # p file if File.exist?(file)
    File.exist?(file)
  end

end
