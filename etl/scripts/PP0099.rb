require_relative 'common'

results = {}
results[:partido_errors] = 0
results[:partido_success] = 0
results[:fecha_errors] = 0
results[:fecha_success] = 0

results[:trimestres_informados] = {:new => 0,
                                  :errors => 0,
                                  :found => 0}

results[:start_time] = 0
results[:end_time] = 0

pre_process do
  results[:start_time] = Time.now
  p "*** Start #{job_name} Marco Normativo MIGRATION #{results[:start_time]}***"
end

system 'head -1 ' + input_path + 'TA_Marco_normativo.csv > ' + input_path + 'PP0099.csv'
system 'cat ' + input_path + 'TA_Marco_normativo.csv | awk \'BEGIN { FS=";" } $2 ~ "PP*" { print }\' >> ' + input_path + 'PP0099.csv'


files = Dir[input_path + "#{job_name}.csv"]

dos2unix
encoding = find_encoding

if encoding == 'unknown-8bit'
  iconv(encoding: 'windows-1252')
elsif encoding == 'iso-8859-1'
  iconv(encoding: encoding)
end

remove_ctrl_m

files.each_with_index do |file, index|

  source SymbolsCSVSource, filename: file, results: results, print_headers: true

end

transform HeadersForMarcoNormativo, verbose: verbosing, results: results

transform PartidoLookup, verbose: verbosing, results: results

transform TrimestreInformadoLookup, verbose: verbosing,  results: results

destination NormasDestination, verbose: verbosing, results: results

destination ErrorCSVDestination, log_path: log_path, filename: job_name + '.log'

# show_me!

limit ENV['LIMIT']

post_process do
  results[:end_time] = Time.now
  ap results
  date = ENV['DATE']
  save_etl_run(job_name, results, date)
  duration_in_minutes = (results[:end_time] - results[:start_time])/60
  puts "*** Duration (min): #{duration_in_minutes.round(2)}"
end