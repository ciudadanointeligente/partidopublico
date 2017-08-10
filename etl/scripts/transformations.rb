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
    partido.url = row[:sitio_del_partido]

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
    code = row[:cdigo_del_organismo].nil? ? row[:organismo_codigo] : row[:cdigo_del_organismo]
    partido = Partido.where(cplt_code: code ).first_or_initialize
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

class HeadersForMarcoNormativo

  def initialize(verbose:, results:)
    @verbose = verbose
    @results = results
  end

  def process(row)
    row[:cdigo_del_organismo] = row[:organismo_codigo]
    row[:ao_informado] = row[:anyo]
    row[:trimestre_informado] = row[:mes]
    row[:trimestre_informado] = "Ene - Mar"
    row[:tipo_marco_normativo] = row[:tipo_de_marco_normativo]
    row[:tipo] = row[:tipo_norma]
    row[:link] = row[:enlace_publicacion]

    row
  end
end


class TrimestreInformadoLookup
  def initialize(verbose:, results:)
    @verbose = verbose
    @results = results
  end

  def process(row)
    p row if @verbose
    ano = row[:ao_informado].nil? ? row[:anyo].to_i : row[:ao_informado].to_i
    unless row[:trimestre_informado].nil?
      trimestre = row[:trimestre_informado].downcase
      trimestre.gsub!(/[^0-9a-z]/i, '')
      trimestre.insert(3, ' - ')
      ordinal_trimestre = ordinal_trimestres.index(trimestre[0].downcase) unless trimestre.nil?
    end

    if (ordinal_trimestre.nil? || ano == 0)
      # p ano
      # if ordinal_trimestre.nil?
      row[:trimestre_informado_id] = nil
      row[:error_log] = row[:error_log].to_s + ', trimestre_informado no válido'
      @results[:trimestres_informados][:errors] += 1
    else
      # p "Trimestre informado: " + ano.to_s + ' ' + trimestre.to_s + " | Ordinal: " + ordinal_trimestre.to_s

      trimestre_informado = TrimestreInformado.where(ano: ano, trimestre: trimestre,
                                                      ordinal: ordinal_trimestre).first_or_initialize

      if trimestre_informado.id.nil?
        trimestre_informado.save
        if trimestre_informado.errors.any?
          row[:error_log] = row[:error_log].to_s + ', ' + trimestre_informado.errors.messages.to_s
          @results[:trimestres_informados][:errors] += 1
          row[:trimestre_informado_id] = nil
        else
          row[:trimestre_informado_id] = trimestre_informado.id
          @results[:trimestres_informados][:new] += 1
        end
      else
        row[:trimestre_informado_id] = trimestre_informado.id
        @results[:trimestres_informados][:found] += 1
      end
    end
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
    if !row[:cargo].nil?
      titulo = row[:cargo]

      tipo_cargo = TipoCargo.where(partido_id: row[:partido_id], titulo: titulo,
                                  cargo_interno: true).first_or_initialize
    else
      titulo = 'Candidato a ' + row[:tipo_eleccin].to_s + ' ' + row[:ao_eleccin]
      tipo_cargo = TipoCargo.where(partido_id: row[:partido_id], titulo: titulo,
                                  candidato: true).first_or_initialize
    end

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
      # p 'TIPO CARGO LOOKUP >>'
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

     if !row[:declaracin_de_intereses_y_patrimonio].nil?
       persona = Persona.where(partido_id: row[:partido_id],
                               nombre: row[:nombre],
                               apellidos: row[:apellidos],
                               intereses: row[:declaracin_de_intereses_y_patrimonio]).first_or_initialize
     else
       persona = Persona.where(partido_id: row[:partido_id],
                               nombre: row[:nombre],
                               apellidos: row[:apellidos]).first_or_initialize
     end

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
     if !row[:persona].nil?
       input = row[:persona].downcase.titleize
     else
       input = row[:nombre_completo_del_candidato].downcase.titleize
     end
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

    if !row[:nombre_comuna].nil?
      string = row[:nombre_comuna] || ''
      comuna = Comuna.where('lower(nombre) = ?', string.downcase).first
    elsif !row[:comuna].nil?
      string = row[:comuna]
      comuna = Comuna.where('lower(nombre) = ?', string.downcase).first
    end

    row[:region_id] = comuna.nil? ? nil : comuna.provincia.region.id

    if comuna.nil?
      row[:comuna_id] = nil
      @results[:comunas][:comunas_errors] += 1 if row[:nombre_distrito].nil?
    else
      row[:comuna_id] = comuna.id
      @results[:comunas][:found_comunas] += 1
    end

    p row if @verbose
    row
  end
end
class DistritoLookup
  def initialize(verbose:, results:)
    @verbose = verbose
    @results = results
  end

  def process(row)

    unless row[:nombre_distrito].nil?
      string = row[:nombre_distrito].gsub(/[a-z]/i, '').gsub(' ', '') || ''
      distrito = Distrito.where('lower(nombre) = ?', string.downcase).first

      if distrito.nil?
        row[:distrito_id] = nil
        @results[:distritos][:distritos_errors] += 1
      else
        row[:distrito_id] = distrito.id
        @results[:distritos][:found_distritos] += 1
      end

      p row if @verbose
    end
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
    ano = row['Año']
    mes = (meses.index((row['Mes'] || '').downcase) || 0) + 1
    row[:fecha_datos] = Date.new(ano.to_i, mes.to_i, 01)
    p row if @verbose
    row
  end
end

class IngresoOrdinarioLookup
  def initialize(verbose:, results:)
    @verbose = verbose
    @results = results
  end

  def process(row)
    p row if @verbose
    concepto = row[:item].downcase.titleize
    importe = row[:monto]

    ingreso_ordinario = IngresoOrdinario.where(partido_id: row[:partido_id],
                                               concepto: concepto,
                                               importe: importe).first_or_initialize

    if ingreso_ordinario.id.nil?
      # ingreso_ordinario.save
      if ingreso_ordinario.errors.any?
        row[:error_log] = row[:error_log].to_s + ', ' + ingreso_ordinario.errors.messages.to_s
        @results[:ingreso_ordinarios][:errors] += 1
      else
        row[:ingreso_ordinario_id] = ingreso_ordinario.id
        @results[:ingreso_ordinarios][:new] += 1
      end
    else
      row[:ingreso_ordinario_id] = ingreso_ordinario.id
      @results[:ingreso_ordinarios][:found] += 1
    end
    row
  end
end

class TerritorioElectoralTransformation
  def initialize(verbose:, results:)
    @verbose = verbose
    @results = results
  end

  def process(row)
    p row if @verbose
    input = row[:tipo_eleccin].downcase

    case input
    when 'concejal'
      row[:nombre_comuna] = row[:territorio_electoral].downcase

    when 'alcaldicia'
      row[:nombre_comuna] = row[:territorio_electoral].downcase
    when 'diputados'
      row[:nombre_distrito] = row[:territorio_electoral].downcase
    else
      row[:nombre_comuna] = nil
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
    # if row[:comuna_id].nil?
    #   @results[:comuna_id_errors] = @results[:comuna_id_errors] + 1
    # else
    #   @results[:comuna_id_success] = @results[:comuna_id_success] + 1
    # end
    # if row[:comuna].nil?
    #   @results[:comuna_errors] = @results[:comuna_errors] + 1
    # else
    #   @results[:comuna_success] = @results[:comuna_success] + 1
    # end
    row
  end
end
