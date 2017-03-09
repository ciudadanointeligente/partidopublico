require 'csv'
require 'awesome_print'
require 'facets/kernel/deep_copy'
require_relative '../../config/environment'

class SedesDestination
  def initialize(results:, verbose:)
    @verbose = verbose
    @new_sedes = 0
    @found_sedes = 0
    @sedes_errors = 0
    @results = results
  end

  def write(row)
    sede = Sede.where(partido_id: row[:partido_id], region_id: row[:region_id],
    comuna_id: row[:comuna_id], direccion: row[:address]).first_or_initialize
    trimestre_informado = TrimestreInformado.find(row[:trimestre_informado_id])
    if sede.id.nil?
      sede.save
      if sede.errors.any?
        # p sede.errors
        row[:error_log] = row[:error_log].to_s + ', ' + sede.errors.messages.to_s
        @sedes_errors = @sedes_errors + 1
      else
        sede.trimestre_informados << trimestre_informado unless trimestre_informado.in?(sede.trimestre_informados)
        @new_sedes = @new_sedes + 1 unless sede.errors.any?
      end
    else
      sede.trimestre_informados << trimestre_informado unless trimestre_informado.in?(sede.trimestre_informados)
      @found_sedes = @found_sedes + 1
    end
  end

  def close
  @results[:sedes] = {:new_sedes => @new_sedes ,
    :sedes_errors => @sedes_errors,
    :found_sedes => @found_sedes}
  end
end

class OrganoInternosDestinations
  def initialize(results:, verbose:)
    @verbose = verbose
    @results = results
  end
    #organo_internos = OrganoInterno.where()
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

          class ErrorCSVDestination
            def initialize(filename:)
              @csv = CSV.open(filename, 'w')
              @headers_written = false
            end

            def write(row)
              unless row[:error_log].nil?
                unless @headers_written
                  @headers_written = true
                  @csv << row.keys
                end
                @csv << row.values
              end
            end

            def close
              @csv.close
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
