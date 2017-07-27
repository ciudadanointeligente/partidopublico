require_relative 'common'
date = ENV['DATE']
if date == nil
  date = today
end
p "Starting etl process for all scripts, loading files from date : " + date.to_s

files = Dir["etl/scripts/PP*.rb"].sort

files.each do |file|
  system("DATE=#{date} bundle exec kiba #{file}")
end
