require 'csv'
require 'awesome_print'
require 'facets/kernel/deep_copy'
require_relative '../../config/environment'
require_relative 'sources'
require_relative 'destinations'
require_relative 'tranformations'

def etl_path
  # File.dirname(__FILE__).parent
  File.dirname(File.expand_path('..', __FILE__))
end

def input_path
  etl_path + "/input_files/cplt/20170303/"
end

def log_path
  etl_path + "/log/"
end

def job_name
  caller.first.split('/').last.split('.').first
end

def meses
  ['enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiemre','octubre','noviembre','diciembre']
end

def dos2unix
  job_name = caller.first.split('/').last.split('.').first
  command = "dos2unix #{input_path}#{job_name}.csv"
  system command
end

def cat_conversion
  job_name = caller.first.split('/').last.split('.').first
  command = "cat -v #{input_path}#{job_name}.csv > #{input_path}#{job_name}_tmp.csv"
  system command
  command = "cat -v #{input_path}#{job_name}_tmp.csv > #{input_path}#{job_name}.csv"
  system command
  command = "rm #{input_path}#{job_name}_tmp.csv"
  system command
end

def find_encoding
  job_name = caller.first.split('/').last.split('.').first
  returned = `file -i #{input_path}#{job_name}.csv`
  tmp_encoding = returned.split("charset=").last
  tmp_encoding.slice! "\n"
  tmp_encoding
end

def iconv(encoding:)
  job_name = caller.first.split('/').last.split('.').first
  command = "iconv  -f #{encoding.upcase} -t UTF-8 #{input_path}#{job_name}.csv > #{input_path}#{job_name}_tmp.csv"
  system command
  command = "cat #{input_path}#{job_name}_tmp.csv > #{input_path}#{job_name}.csv"
  system command
  command = "rm #{input_path}#{job_name}_tmp.csv"
  system command
end

def show_me!
  transform do |row|
    ap row
    row
  end
end

def limit(x)
  x = Integer(x || -1)
  return if x == -1
  transform do |row|
    @counter ||= 0
    @counter += 1
    abort('Limit reached, Stopping ...') if @counter >= x
    row
  end
end
