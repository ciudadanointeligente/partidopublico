require_relative 'common'
date = ENV['DATE']
if date == nil
  date = today
end
p "Starting etl process for all scripts, loading files from date : " + date.to_s

system("DATE=#{date} bundle exec kiba etl/scripts/PP0002.rb")
system("DATE=#{date} bundle exec kiba etl/scripts/PP0003.rb")
system("DATE=#{date} bundle exec kiba etl/scripts/PP0004.rb")
system("DATE=#{date} bundle exec kiba etl/scripts/PP0005.rb")
system("DATE=#{date} bundle exec kiba etl/scripts/PP0007.rb")
system("DATE=#{date} bundle exec kiba etl/scripts/PP0008.rb")
system("DATE=#{date} bundle exec kiba etl/scripts/PP0011.rb")
system("DATE=#{date} bundle exec kiba etl/scripts/PP0012.rb")
system("DATE=#{date} bundle exec kiba etl/scripts/PP0013.rb")
system("DATE=#{date} bundle exec kiba etl/scripts/PP0014.rb")
system("DATE=#{date} bundle exec kiba etl/scripts/PP0018.rb")
