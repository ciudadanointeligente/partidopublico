require 'csv'
require 'awesome_print'
require 'facets/kernel/deep_copy'
require_relative '../../config/environment'

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
