require 'csv'
require 'awesome_print'
require_relative '../../config/environment'

def meses
  ['enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiemre','octubre','noviembre','diciembre']
end

class CSVSource
  def initialize(filename:)
    @filename = filename
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

class PartidoLookup
  def initialize(verbose:)
    @verbose = verbose

  end

  def process(row)
    sigla = row[:filename].split('-')[1].split('.')[0].strip
    partido = Partido.find_by_sigla(sigla)
    partido_id = partido.nil? ? nil : partido.id
    row[:partido_id] = partido_id
    row
  end
end

class RegionLookup
  def initialize(verbose:)
    @verbose = verbose
  end

  def process(row)
    # p "row Region: " + row['Región']
    region = Region.find_by_nombre(row['Región'])
    region_id = region.nil? ? nil : region.id
    row[:region_id] = region_id
    row
  end
end

class ComunaLookup
  def initialize(verbose:)
    @verbose = verbose

  end

  def process(row)
    comuna = Comuna.find_by_nombre(row['Comuna'])
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
    row[:address] = row['Avenida, Calle o Pasaje'].to_s + ' ' + row['Número del inmueble, depto u oficina'].to_s
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
    mes = meses.index(row['Mes'].downcase) + 1
    row[:fecha_datos] = Date.new(ano.to_i, mes.to_i, 01)
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
    @updated_sedes = 0
    @sedes_errors = 0
    @results = results
  end

  def write(row)
    sede = Sede.where(partido_id: row[:partido_id], region_id: row[:region_id], comuna_id: row[:comuna_id], direccion: row[:address]).first_or_initialize
    if sede.id.nil?
      sede.save
      @new_sedes = @new_sedes + 1 unless sede.errors.any?
      @sedes_errors = @sedes_errors + 1 if sede.errors.any?
    else
      @updated_sedes = @updated_sedes + 1
    end
  end

  def close
    @results[:new_sedes] = @new_sedes
    @results[:sedes_errors] = @sedes_errors
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
