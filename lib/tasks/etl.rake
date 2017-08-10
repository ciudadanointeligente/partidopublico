namespace :etl do
  desc "papu etl"
  task :start, [:date] => [:environment] do |t, args|
    if args[:date].nil?
      p 'usage: rake etl:test[YYYYMMDD]'
    else
      p args[:date]
      date = args[:date]
      system 'mkdir etl/log/' + date + '/'
      system 'wget -r -np -nH –cut-dirs=2 --accept csv https://datos.partidospublicos.cl/'+ date +'/ -P etl/input_files/cplt'
      system 'wget   https://datos.partidospublicos.cl/PP0002_extra.csv -P etl/input_files/cplt/' + date +'/'
      system 'rm etl/input_files/cplt/' + date + '/*html*'
      command = 'DATE=' + date + ' RAILSENV=' + Rails.env + ' bundle exec kiba etl/scripts/import_all.rb'
      result = system command
    end
  end

end
