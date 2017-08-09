class RunEtlJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    p "ETL Delayed Job"
    date = Time.now().strftime("%Y%m%d")
    p date
    system 'mkdir etl/log/' + date + '/'
    system 'wget -r -np -nH –cut-dirs=2 --accept csv https://datos.partidospublicos.cl/'+ date +'/ -P etl/input_files/cplt'
    system 'wget   https://datos.partidospublicos.cl/PP0002_extra.csv -P etl/input_files/cplt/' + date +'/'
    system 'rm etl/input_files/cplt/' + date + '/*html*'
    command = 'DATE=' + date + ' RAILSENV=development bundle exec kiba etl/scripts/import_all.rb'
    result = system command
  end
end
