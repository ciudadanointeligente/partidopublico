
date = ENV['DATE']
if date == nil
  system("bundle exec kiba etl/scripts/PP0002.rb")
  system("bundle exec kiba etl/scripts/PP0003.rb")
else
system("DATE=#{date} bundle exec kiba etl/scripts/PP0002.rb")
system("DATE=#{date} bundle exec kiba etl/scripts/PP0003.rb")
end
