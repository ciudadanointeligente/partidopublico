
date = ENV['DATE']
system("DATE=#{date} bundle exec kiba etl/scripts/PP0002.rb")
system("DATE=#{date} bundle exec kiba etl/scripts/PP0003.rb")
