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

    partido.nombre = row[:nombre_del_organismo]
    partido.sigla = row[:sigla]
    partido.lema = row[:lema_del_partido_poltico]

    found = !partido.id.nil?
    if partido.nombre.in?(n_a_values)
      @results[:partido_errors] += 1
      row[:error_log] = "N/A value on required field"
    else
      partido.save
      if partido.errors.any?
        @results[:partidos][:partidos_errors] += 1
        row[:error_log] = partido.errors.messages
      else
        if found
          @results[:partidos][:found_partidos] += 1
        else
          @results[:partidos][:new_partidos] += 1
        end
        row[:partido_id] = partido.id
      end
    end
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
    if partido.id.nil?
      @results[:partido_errors] += 1
      row[:error_log] = "Partido NOT FOUND IN DB"
    else
      @results[:partido_success] += 1
      row[:partido_id] = partido.id
    end
    row
  end
end


class TrimestreInformadoLookup
  def initialize(verbose:)
    @verbose = verbose
  end

  def process(row)
    p row if @verbose
    ano = row[:ao_informado].to_i;
    trimestre = row[:trimestre_informado];

    trimestre_informado = TrimestreInformado.where(ano: ano, trimestre: trimestre).first_or_create
    row[:trimestre_informado_id] = trimestre_informado.id
    p row if @verbose
    row
  end
end

class OrganoInternoLookup
  def initialize(verbose:, results:)
    @verbose = verbose
    @results = results
  end

  def process(row)
    p row if @verbose
    input = row.clone if @verbose
    nombre = row[:unidades_u_rganos_internos]

    organo_interno = OrganoInterno.where(partido_id: row[:partido_id],
                                         nombre: nombre).first_or_initialize

    if organo_interno.id.nil?
      @results[:organo_internos][:not_found_organo_internos] += 1
    else
      @results[:organo_internos][:found_organo_internos] += 1
    end
    row[:organo_interno_id] = organo_interno.id
    if @verbose
      output = row.clone
      p 'ORGANO INTERNO LOOKUP >>'
      input.map{|k, v| output.delete(k)}
      p output
    end
    row
  end
end

class TipoCargoLookup
  def initialize(verbose:, results:)
    @verbose = verbose
    @results = results
  end

  def process(row)
    # p row if @verbose
    input = row.clone if @verbose
    titulo = row[:cargo]
    #  cargo_interno = [:cargo_interno]
    #  representante = [:representante]
    #  autoridad = [:autoridad]
    #  candidato = [:candidato]

    tipo_cargo = TipoCargo.where(partido_id: row[:partido_id], titulo: titulo,
                                cargo_interno: true).first_or_initialize

    if tipo_cargo.id.nil?
      tipo_cargo.save
      if tipo_cargo.errors.any?
        row[:error_log] = row[:error_log].to_s + ', ' + tipo_cargo.errors.messages.to_s
        @results[:tipo_cargos][:tipo_cargos_errors] += 1
      else
        row[:tipo_cargo_id] = tipo_cargo.id
        @results[:tipo_cargos][:new_tipo_cargos] += 1
      end
    else
      row[:tipo_cargo_id] = tipo_cargo.id
      @results[:tipo_cargos][:found_tipo_cargos] += 1
    end

    if @verbose
      output = row.clone
      p 'TIPO CARGO LOOKUP >>'
      input.map{|k, v| output.delete(k)}
      p output
    end
    row
  end
end

class PersonaLookupAndInsert
   def initialize(verbose:, results:)
     @verbose = verbose
     @results = results
   end

   def process(row)
    #  nombre = [:nombre]
    #  apellidos = [:apellidos]
    #  rut = [:rut]
     input = row.clone if @verbose

     persona = Persona.where(partido_id: row[:partido_id], nombre: row[:nombre],
     apellidos: row[:apellidos]).first_or_initialize
     if persona.id.nil?
       persona.rut = SecureRandom.uuid
       persona.save
       if persona.errors.any?
         row[:error_log] = row[:error_log].to_s + ', ' + persona.errors.messages.to_s
         @results[:personas][:personas_errors] += 1
       else
         row[:persona_id] = persona.id
        #  p "persona: " + persona.to_s
        @results[:personas][:new_personas] += 1
       end
     else
       row[:persona_id] = persona.id
       @results[:personas][:found_personas] += 1
      end
      if @verbose
        output = row.clone
        p 'PERSONA LOOKUP >>'
        input.map{|k, v| output.delete(k)}
        p output
      end
     row
   end
 end

 class NombreTransformation
   def initialize(verbose:)
     @verbose = verbose
   end

   def process(row)
     p row if @verbose
     input = row[:persona].downcase.titleize
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
    p row if @verbose
    row[:address] = row[:avenida_calle_o_pasaje].to_s + ' ' + row[:nmero_del_inmueble_depto_u_oficina].to_s
    p row if @verbose
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
