require_relative 'common'

results = {}
results[:region_errors] = 0
results[:region_success] = 0
results[:partido_errors] = 0
results[:partido_success] = 0
results[:fecha_errors] = 0
results[:fecha_success] = 0
results[:comuna_errors] = 0
results[:comuna_success] = 0
results[:comuna_id_errors] = 0
results[:comuna_id_success] = 0

results[:start_time] = 0
results[:end_time] = 0

pre_process do
  results[:start_time] = Time.now
  p "*** Start #{job_name}  MIGRATION #{results[:start_time]}***"
end

# p input_path + "#{job_name}.csv"
files = Dir[input_path + "#{job_name}.csv"]
# p files
dos2unix
encoding = find_encoding
if encoding == 'unknown-8bit'
  iconv(encoding: 'windows-1252')
elsif encoding == 'iso-8859-1'
  iconv(encoding: encoding)
end

files.each_with_index do |file, index|

  p "Processing file : " + file.to_s

  source SymbolsCSVSource, filename: file, results: results, print_headers: false
end


transform PartidoLookup, verbose: false, results: results

# show_me!

transform TrimestreInformadoTransformation, verbose: false

# transform RegionLookup, verbose: false, results: results

transform ComunaLookup, verbose: false, results: results

transform AddressTransformation, verbose: false

transform ResultsTransformation, results: results

destination SedesDestination, results: results,
                              verbose: false

destination ErrorCSVDestination, filename: log_path + job_name + '.log'



limit ENV['LIMIT']

# show_me!

post_process do
  results[:end_time] = Time.now
  ap results
  duration_in_minutes = (results[:end_time] - results[:start_time])/60
  puts "*** Duration (min): #{duration_in_minutes.round(2)}"
end