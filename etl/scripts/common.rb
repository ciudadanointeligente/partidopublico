require 'csv'
require 'awesome_print'
require 'facets/kernel/deep_copy'
require_relative '../../config/environment'

def meses
  ['enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiemre','octubre','noviembre','diciembre']
end


class NormalizingCsvSource
  def initialize(filename:, results:)
    @filename = filename
    @results = results
    #@csv = CSV.open(input_file, headers: true, header_converters: :symbol)
    @total = CSV.read(@filename, headers: true).length
    count
  end

  def count()
      @results[:input_rows] = @results[:input_rows].nil? ? @total : @results[:input_rows] + @total
  end

  def each
    csv = CSV.open(@filename, headers: true)
    csv.each do |row|
      row = row.to_hash
      group = row['Personas que lo integran'] || ''
      group.split("\n").each do |persona|
        row[:filename] = @filename
        yield(row.deep_copy.merge(persona: persona))
      end
    end
    csv.close
  end
end

class CSVSource
  @total = 0

  def initialize(filename:, results:)
    @filename = filename
    @results = results
    @total = CSV.read(@filename, headers: true).length
    count
  end

  def count()
      @results[:input_rows] = @results[:input_rows].nil? ? @total : @results[:input_rows] + @total
   end

  def each
    csv = CSV.open(@filename, headers: true)
    csv.each do |row|
      row[:filename] = @filename
      yield row.to_hash
    end
    csv.close
  end
end

class SymbolsCSVSource
  @total = 0

  def initialize(filename:, results:)
    p "init SymbolsCSVSource"
    @filename = filename
    @results = results
    @total = CSV.read(@filename, headers: true).length
    count
  end

  def count()
      @results[:input_rows] = @results[:input_rows].nil? ? @total : @results[:input_rows] + @total
  end

  def each
    csv = CSV.open(@filename, headers: true, :col_sep => ";", :row_sep => "\n", header_converters: :symbol, encoding: "iso-8859-1")
    # csv = CSV.open(@filename, headers: true, header_converters: :symbol, :col_sep => ";",:row_sep => "\n")
    # p "each SymbolsCSVSource :" + @filename
    csv.each do |row|
      yield row.to_hash
    end
    csv.close
  end
end

class PartidoLookupAndInsert

  def initialize(verbose:, results:)
    @verbose = verbose
    @results = results
  end

  def process(row)
    partido = Partido.where(cplt_code: row[:cdigo_del_organismo]).first_or_initialize
    # p partido
    partido.nombre = row[:nombre_del_organismo]
    partido.lema = row[:lema_del_partido_poltico]
    # {:cdigo_del_organismo=>"PP006", :nombre_del_organismo=>"Partido Movimiento Independiente Regionalista Agrario y Social (MIRAS)", :nombre_completo=>"Movimiento Independiente Regionalista Agrario y Social", :sigla=>"MIRAS", :lema_del_partido_poltico=>"Sin información", :filename=>"/home/jordi/development/partidopublico/etl/input_files/cplt/PP0002.csv"}
    # p row
    partido.sigla = row[:sigla]
    partido.save
    if partido.errors.any?
      p partido.errors
      p row
      @results[:partido_errors] += 1
    else
      @results[:partido_success] += 1
    end
    partido_id = partido.nil? ? nil : partido.id
    row[:partido_id] = partido_id
    row
  end
end

class PartidoLookup

  def initialize(verbose:, results:)
    @verbose = verbose
    @results = results
  end

  def process(row)
    partido = Partido.where(cplt_code: row[:cdigo_del_organismo]).first_or_initialize

    if partido.nil?
      @results[:partido_errors] += 1
    else
      @results[:partido_success] += 1
    end
    row[:partido_id] = partido.id
    row
  end
end

class RegionLookup
  def initialize(verbose:, results:)
    @verbose = verbose
    @results = results
  end

  def process(row)
    # p "row Region: " + row['Región']
    region = Region.find_by_nombre(row[:regin])
    if region.nil?
      @results[:region_errors] += 1
    else
      @results[:region_success] += 1
      row[:region_id] = region.id
    end
    row
  end
end

class ComunaLookup
  def initialize(verbose:, results:)
    @verbose = verbose
    @results = results

  end

  def process(row)
    # comuna = Comuna.find_by_nombre(row['Comuna'])
    string = row[:comuna] || ''
    comuna = Comuna.where('lower(nombre) = ?', string.downcase).first

    comuna_id = comuna.nil? ? nil : comuna.id
    region_id = comuna.nil? ? nil : comuna.provincia.region.id
    row[:comuna_id] = comuna_id
    row[:region_id] = region_id
    row
  end
end

class AddressTransformation
  def initialize(verbose:)
    @verbose = verbose

  end

  def process(row)
    row[:address] = row[:avenida_calle_o_pasaje].to_s + ' ' + row[:nmero_del_inmueble_depto_u_oficina].to_s
    row
  end
end

class FechaDatosTransformation
  def initialize(verbose:)
    @verbose = verbose
  end

  def process(row)
    p row if @verbose
    ano = row['Año'];
    mes = (meses.index((row['Mes'] || '').downcase) || 0) + 1
    row[:fecha_datos] = Date.new(ano.to_i, mes.to_i, 01)
    p row if @verbose
    row
  end
end

class NombreTransformation
  def initialize(verbose:)
    @verbose = verbose
  end

  def process(row)
    p row if @verbose
    input = row['Nombre completo del candidato'];
    words = input.split
    if words.size > 3
      row[:nombre] = words[0] + ' ' + words[1]
      row[:apellidos] = words[2] + ' ' + words[3]
    else
      row[:nombre] = words[0]
      row[:apellidos] = (words[1] || '') + ' ' + (words[2] || '')
    end
    p row if @verbose
    row
  end
end

class TerritorioElectoralTransformation
  def initialize(verbose:)
    @verbose = verbose
  end

  def process(row)
    p row if @verbose
    input = row['Tipo Elección'];

    case input
    when 'Concejal'
      row['Comuna'] = row['Territorio electoral']
    when 'Alcalde'
      row['Comuna'] = row['Territorio electoral']
    else
      row[':comuna'] = nil
    end

    p row if @verbose
    row
  end
end

class ResultsTransformation
  def initialize(results:)
    @results = results
  end

  def process(row)
    if row[:region_id].nil?
      @results[:region_errors] = @results[:region_errors] + 1
    else
      @results[:region_success] = @results[:region_success] + 1
    end
    if row[:partido_id].nil?
      @results[:partido_errors] = @results[:partido_errors] + 1
    else
      @results[:partido_success] = @results[:partido_success] + 1
    end
    if row[:fecha_datos].nil?
      @results[:fecha_errors] = @results[:fecha_errors] + 1
    else
      @results[:fecha_success] = @results[:fecha_success] + 1
    end
    if row[:comuna_id].nil?
      @results[:comuna_id_errors] = @results[:comuna_id_errors] + 1
    else
      @results[:comuna_id_success] = @results[:comuna_id_success] + 1
    end
    if row[:comuna].nil?
      @results[:comuna_errors] = @results[:comuna_errors] + 1
    else
      @results[:comuna_success] = @results[:comuna_success] + 1
    end
    row
  end
end

class SedesDestination
  def initialize(results:, verbose:)
    @verbose = verbose
    @new_sedes = 0
    @found_sedes = 0
    @sedes_errors = 0
    @results = results
  end

  def write(row)
    sede = Sede.where(partido_id: row[:partido_id], region_id: row[:region_id], comuna_id: row[:comuna_id], direccion: row[:address]).first_or_initialize
    if sede.id.nil?
      sede.save
      if sede.errors.any?
        p sede.errors
      end
      @new_sedes = @new_sedes + 1 unless sede.errors.any?
      @sedes_errors = @sedes_errors + 1 if sede.errors.any?
    else
      @found_sedes = @found_sedes + 1
    end
  end

  def close
    @results[:sedes] = {:new_sedes => @new_sedes ,
                        :sedes_errors => @sedes_errors,
                        :found_sedes => @found_sedes}
  end
end

class NormasDestination
  def initialize(results:, verbose:)
    @verbose = verbose
    @new_normas = 0
    @found_normas = 0
    @normas_errors = 0
    @results = results
  end

  def write(row)
    norma = Norma.where(partido_id: row[:partido_id],
                        denominacion: row['Denominación norma'],
                        tipo: row['Tipo de norma'],
                        numero: row['Número norma']).first_or_initialize

    norma.tipo_marco_normativo = row['Tipo Marco normativo']
    norma.fecha_publicacion = row['Fecha de publicación en el diario oficial o fecha de dictación (dd/mm/aaaa)']
    norma.link = row['Enlace a la publicación o archivo correspondiente']
    norma.fecha_modificacion = row['Fecha de última modificación o derogación (dd/mm/aaaa)']
    norma.fecha_datos = row[:fecha_datos]
    norma.marco_interno = MarcoInterno.where(partido_id: row[:partido_id]).first

    if norma.id.nil?
      norma.save
      @new_normas = @new_normas + 1 unless norma.errors.any?
      @normas_errors = @normas_errors + 1 if norma.errors.any?
    else
      norma.save
      @found_normas = @found_normas + 1
    end

  end

  def close
    @results[:normas] = {:new_normas => @new_normas ,
                        :normas_errors => @normas_errors,
                        :found_normas => @found_normas}
  end
end

class CandidatosDestination
  def initialize(results:, verbose:)
    @verbose = verbose
    @new_candidatos = 0
    @found_candidatos = 0
    @candidatos_errors = 0
    @new_tipo_cargos = 0
    @found_tipo_cargos = 0
    @tipo_cargos_errors = 0
    @new_personas = 0
    @found_personas = 0
    @personas_errors = 0
    @new_cargos = 0
    @found_cargos = 0
    @cargos_errors = 0
    @results = results
  end

  def write(row)
    tipo_cargo = TipoCargo.where(partido_id: row[:partido_id], titulo: row['Tipo Elección'], candidato: true).first_or_initialize
    if tipo_cargo.id.nil?
      tipo_cargo.save
      @new_tipo_cargos = @new_tipo_cargos + 1 unless tipo_cargo.errors.any?
      @tipo_cargos_errors = @tipo_cargos_errors + 1 if tipo_cargo.errors.any?
    else
      @found_tipo_cargos = @found_tipo_cargos + 1
    end

    persona = Persona.where(nombre: row[:nombre], apellidos: row[:apellidos], partido_id: row[:partido_id], rut:  row[:apellidos] +  row[:nombre] +  row[:partido_id].to_s).first_or_initialize
    if persona.id.nil?
      persona.save
      @new_personas = @new_personas + 1 unless persona.errors.any?
      @personas_errors = @personas_errors + 1 if persona.errors.any?
    else
      persona.intereses = row['Declaración de Intereses y Patrimonio']
      persona.patrimonio = row['Declaración de Intereses y Patrimonio']
      persona.save
      @found_personas = @found_personas + 1
    end

    cargo = Cargo.where(persona: persona, tipo_cargo: tipo_cargo, comuna_id: row[:comuna_id]).first_or_initialize
    if cargo.id.nil?
      cargo.save
      @new_cargos = @new_cargos + 1 unless cargo.errors.any?
      @cargos_errors = @cargos_errors + 1 if cargo.errors.any?
    else
      @found_cargos = @found_cargos + 1
    end

  end

  def close
    @results[:candidatos] = {:new_candidatos => @new_candidatos ,
                        :candidatos_errors => @candidatos_errors,
                        :found_candidatos => @found_candidatos}
    @results[:tipo_cargos] = {:new_tipo_cargos => @new_tipo_cargos ,
                        :tipo_cargos_errors => @tipo_cargos_errors,
                        :found_tipo_cargos => @found_tipo_cargos}
    @results[:personas] = {:new_personas => @new_personas ,
                        :personas_errors => @personas_errors,
                        :found_personas => @found_personas}
    @results[:cargos] = {:new_cargos => @new_cargos ,
                        :cargos_errors => @cargos_errors,
                        :found_cargos => @found_cargos}
  end
end

class CSVDestination
  def initialize(filename:)
    @csv = CSV.open(filename, 'w')
    @headers_written = false
  end

  def write(row)
    unless @headers_written
      @headers_written = true
      @csv << row.keys
    end
    @csv << row.values
  end

  def close
    @csv.close
  end
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
