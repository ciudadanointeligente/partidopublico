require_relative 'common'

results = {}
results[:start_time] = 0
results[:end_time] = 0
results[:partidos] = {:new_partidos => 0,
                    :partidos_errors => 0,
                    :found_partidos => 0}

pre_process do
  results[:start_time] = Time.now
  puts "*** Start #{job_name}_extra - Party Basic Info MIGRATION #{results[:start_time]}***"
end

files = Dir[input_path + "#{job_name}_extra.csv"]

dos2unix
encoding = find_encoding

if encoding == 'unknown-8bit'
  iconv(encoding: 'windows-1252')
elsif encoding == 'iso-8859-1'
  iconv(encoding: encoding)
end

files.each_with_index do |file, index|

  source SymbolsCSVSource, filename: file, results: results , print_headers: true

end

transform PartidoLookupAndInsert, verbose: verbosing, results: results

destination ErrorCSVDestination, filename: log_path + job_name + '.log'

# show_me!

post_process do
  results[:end_time] = Time.now
  ap results
  duration_in_minutes = (results[:end_time] - results[:start_time])/60
  puts "*** Duration (min): #{duration_in_minutes.round(2)}"
  save_etl_run(job_name, results)
end
