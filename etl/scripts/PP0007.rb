require_relative 'common'

results = {}
results[:partido_errors] = 0
results[:partido_success] = 0
results[:fecha_errors] = 0
results[:fecha_success] = 0

results[:territorios_electorales] = {:new_territorios_electorales => 0,
                                     :territorios_electorales_errors => 0,
                                     :found_territorios_electorales => 0}

results[:cargos] = {:new_cargos => 0,
                    :cargos_errors => 0,
                    :found_cargos => 0}

results[:tipo_cargos] = {:new_tipo_cargos => 0,
                         :tipo_cargos_errors => 0,
                         :found_tipo_cargos => 0}

results[:personas] = {:new_personas => 0,
                      :personas_errors => 0,
                      :found_personas => 0}

results[:comunas] = {:comunas_errors => 0,
                     :found_comunas => 0}

results[:trimestres_informados] = {:new => 0,
                                  :errors => 0,
                                  :found => 0}

results[:start_time] = 0
results[:end_time] = 0

pre_process do
  results[:start_time] = Time.now
  p "*** Start #{job_name} Candidatos MIGRATION #{results[:start_time]}***"
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

  # p "Processing file : " + file.to_s

  source SymbolsCSVSource, filename: file, results: results, print_headers: true
end


transform PartidoLookup, verbose: verbosing, results: results

transform TerritorioElectoralTransformation, verbose: verbosing, results: results

transform ComunaLookup, verbose: verbosing, results: results

transform TrimestreInformadoLookup, verbose: verbosing,  results: results

transform TipoCargoLookup, verbose: verbosing, results: results

transform NombreTransformation, verbose: verbosing

transform PersonaLookupAndInsert, verbose: verbosing, results: results

destination CargosDestination, verbose: verbosing, results: results

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
