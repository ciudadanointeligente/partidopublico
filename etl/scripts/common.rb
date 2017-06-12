require 'csv'
require 'awesome_print'
require 'facets/kernel/deep_copy'
require_relative '../../config/environment'
require_relative 'sources'
require_relative 'destinations'
require_relative 'transformations'

def clean_number(numero)
  numero = numero.to_s
  numero.delete! ','
  numero.delete! '.'
  # numero.delete! '-'
  numero.to_i
end

CLEAN_PRHASES = {
  :"estamentarias" => "Asignaciones testamentarias",
  :"frutos y productos"=>"Frutos y productos de los bienes patrimoniales",
  :"aportes del estado"=>"Aportes del Estado (Art. 33 Bis Ley N° 18603)",
  :"blicas"=>"Otras transferencias públicas",
  :"privadas"=>"Otras transferencias privadas",
  :"gresos militantes"=>"Ingresos militantes",
  :"personal"=>"Gastos de personal",
  :"gastos corrientes"=>"Gastos de adquisición de bienes y servicios o gastos corrientes",
  :"préstamos de corto plazo"=>"Gastos financieros por préstamos de corto plazo",
  :"préstamos de largo plazo"=>"Gastos financieros por préstamos de largo plazo",
  :"administraci"=>"Otros gastos de administración",
  :"investigaci"=>"Gastos de actividades de investigación",
  :"educación cívica"=>"Gastos de actividades de educación cívica",
  :"femenina"=>"Gastos de actividades de fomento a la particiación femenina",
  :"de los j"=> "Gastos de actividades de fomento a la participación de los jóvenes",
  :"corto plazo, inversiones"=> "Créditos de corto plazo, inversiones y valores de operaciones de capital",
  :"largo plazo, inversiones"=> "Créditos de largo plazo, inversiones y valores de operaciones de capital",
  :"de candidatos a cargos de elecc"=> "Gastos de las actividades de preparación de candidatos a cargos de elección popular",
  :"n de militantes"=> "Gastos de las actividades de formación de militantes",
}

def clean_phrase(frase)
  frase.downcase!
  # p "downcased phrase -> " + frase
  frase.gsub(/[^0-9a-z ]/i, '')
  # p "cleaned phrase -> " + frase
  CLEAN_PRHASES.each do |key, value|
    if frase.include? key.to_s
      return value
    end
  end
  return frase.titleize
end

def today
  date = Time.now().strftime("%Y%m%d")
end

def vali_date(fecha, handler)
  fecha.gsub("/", '-').to_s
  if fecha.length < 3
    fecha = nil
  elsif fecha.length < 10 && fecha.length > 5
    fecha.insert(6, '20')
  end
  begin
      fecha.to_date
  rescue => e
    handled_error = ' ' + e.message + ': ' +fecha.to_s
    return nil, handled_error
  end
end

def save_etl_run(job_name, results, date)
  EtlRun.create(start_time: results[:start_time],
                end_time: results[:end_time],
                job_name: job_name,
                results: results.to_s,
                input_rows: results[:input_rows],
                fecha_datos: date)
end

def n_a_values
  ['Sin información', 'Sin informacion', 'N/A']
end

def ordinal_trimestres
  ['e', 'a', 'j', 'o']
end

def verbosing
  verbose = ENV['VERBOSE']

  unless verbose.nil?
    verbose = verbose.downcase
  end

  if verbose == 'true'
    verbose = true
  elsif verbose.nil?
    verbose = false
  else
    verbose = false
  end
  @verbose = verbose
end

def etl_path
  # File.dirname(__FILE__).parent
  File.dirname(File.expand_path('..', __FILE__))
end

def input_path
  date = ENV['DATE']
  if date == nil
    date = Time.now().strftime("%Y%m%d")
    etl_path + "/input_files/cplt/"+date+"/"
  else
    etl_path + "/input_files/cplt/#{date}/"
  end
end

def log_path
  etl_path + "/log/"
end

def job_name
  caller.first.split('/').last.split('.').first
end

def meses
  ['enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiembre','octubre','noviembre','diciembre']
end

def dos2unix
  job_name = caller.first.split('/').last.split('.').first
  command = "dos2unix #{input_path}#{job_name}.csv"
  system command
end

def cat_conversion
  job_name = caller.first.split('/').last.split('.').first
  command = "cat -v #{input_path}#{job_name}.csv > #{input_path}#{job_name}_tmp.csv"
  system command
  command = "cat -v #{input_path}#{job_name}_tmp.csv > #{input_path}#{job_name}.csv"
  system command
  command = "rm #{input_path}#{job_name}_tmp.csv"
  system command
end

def find_encoding
  job_name = caller.first.split('/').last.split('.').first
  returned = `file -i #{input_path}#{job_name}.csv`
  tmp_encoding = returned.split("charset=").last
  tmp_encoding.slice! "\n"
  tmp_encoding
end

def iconv(encoding:)
  job_name = caller.first.split('/').last.split('.').first
  command = "iconv  -f #{encoding.upcase} -t UTF-8 #{input_path}#{job_name}.csv > #{input_path}#{job_name}_tmp.csv"
  system command
  command = "cat #{input_path}#{job_name}_tmp.csv > #{input_path}#{job_name}.csv"
  system command
  command = "rm #{input_path}#{job_name}_tmp.csv"
  system command
end

def remove_ctrl_m
  job_name = caller.first.split('/').last.split('.').first
  command = "sed -i \"s/^M//g\" #{input_path}#{job_name}.csv"
  p command
  system command
end

def show_me!
  transform do |row|
    ap row
    row
  end
end

def limit(x)
  x = Integer(x || -1)
  return if x == -1
  transform do |row|
    @counter ||= 0
    @counter += 1
    abort('Limit reached, Stopping ...') if @counter >= x
    row
  end
end
