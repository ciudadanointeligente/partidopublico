require_relative 'common'

results = {}
results[:region_errors] = 0
results[:region_success] = 0
results[:partido_errors] = 0
results[:partido_success] = 0
results[:fecha_errors] = 0
results[:fecha_success] = 0
results[:comunas] = {:comunas_errors => 0,
                     :found_comunas => 0}

results[:trimestres_informados] = {:new => 0,
                                   :errors => 0,
                                   :found => 0}

results[:start_time] = 0
results[:end_time] = 0

pre_process do
  results[:start_time] = Time.now
  p "*** Start #{job_name} Sedes MIGRATION #{results[:start_time]}***"
end

files = Dir[input_path + "#{job_name}.csv"]

dos2unix
encoding = find_encoding

if encoding == 'unknown-8bit'
  iconv(encoding: 'windows-1252')
elsif encoding == 'iso-8859-1'
  iconv(encoding: encoding)
end

files.each_with_index do |file, index|

  source SymbolsCSVSource, filename: file, results: results, print_headers: true

end

transform PartidoLookup, verbose: verbosing, results: results

transform TrimestreInformadoLookup, verbose: verbosing,  results: results

transform ComunaLookup, verbose: verbosing, results: results

transform AddressTransformation, verbose: verbosing

transform ResultsTransformation, results: results

destination SedesDestination, verbose: verbosing, results: results

destination ErrorCSVDestination, filename: log_path + job_name + '.log'

# show_me!

limit ENV['LIMIT']

post_process do
  results[:end_time] = Time.now
  ap results
  duration_in_minutes = (results[:end_time] - results[:start_time])/60
  puts "*** Duration (min): #{duration_in_minutes.round(2)}"
  save_etl_run(job_name, results)
end
