date = ENV['DATE']
if date == nil
  system("bundle exec kiba etl/scripts/PP0002.rb")
  system("bundle exec kiba etl/scripts/PP0003.rb")
  system("bundle exec kiba etl/scripts/PP0004.rb")
  system("bundle exec kiba etl/scripts/PP0005.rb")
  system("bundle exec kiba etl/scripts/PP0007.rb")
  system("bundle exec kiba etl/scripts/PP0008.rb")
else
  system("DATE=#{date} bundle exec kiba etl/scripts/PP0002.rb")
  system("DATE=#{date} bundle exec kiba etl/scripts/PP0003.rb")
  system("DATE=#{date} bundle exec kiba etl/scripts/PP0004.rb")
  system("DATE=#{date} bundle exec kiba etl/scripts/PP0005.rb")
  system("DATE=#{date} bundle exec kiba etl/scripts/PP0007.rb")
  system("DATE=#{date} bundle exec kiba etl/scripts/PP0008.rb")
end
