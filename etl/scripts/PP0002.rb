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
  puts "*** Start PP0002 - Party Basic Info MIGRATION #{results[:start_time]}***"
end

input_path = "/home/jordi/development/partidopublico/etl/input_files/cplt/20170301/"

files = Dir[input_path + 'PP0002.*']


files.each_with_index do |file, index|

  p "Processing file : " + (index + 1).to_s + '/' + files.size.to_s

  source SymbolsCSVSource, filename: file,
                    results: results
end

transform PartidoLookupAndInsert, verbose: false, results: results

# transform FechaDatosTransformation, verbose: false
#
# transform RegionLookup, verbose: false
#
# transform ComunaLookup, verbose: false
#
# transform AddressTransformation, verbose: false
#
# transform ResultsTransformation, results: results
#
# destination SedesDestination, results: results,
#                               verbose: false

limit ENV['LIMIT']

# show_me!

post_process do
  results[:end_time] = Time.now
  ap results
  duration_in_minutes = (results[:end_time] - results[:start_time])/60
  puts "*** Duration (min): #{duration_in_minutes.round(2)}"
end
