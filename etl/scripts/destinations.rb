require 'csv'
require 'awesome_print'
require 'facets/kernel/deep_copy'
require_relative 'common'
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

    sede = Sede.where(partido_id: row[:partido_id],
                      region_id: row[:region_id],
                      comuna_id: row[:comuna_id],
                      direccion: row[:address]).first_or_initialize

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

class RegionPorPartidoDestination
  def initialize(results:)
    @results = results
  end

  def write(row)

    sede = Sede.where(partido_id: row[:partido_id],
                      region_id: row[:region_id],
                      comuna_id: row[:comuna_id],
                      direccion: row[:address]).first_or_initialize

    # p "ID REGION " + row[:region_id].to_s
    # p "ID PARTIDO " + row[:partido_id].to_s
    # p "ROW " + row.to_s
    if !row[:partido_id].nil?
      partido = Partido.find(row[:partido_id])

      unless row[:region_id].nil?
        region = Region.find(row[:region_id])
        partido.regions << region unless region.in?(partido.regions)
      end
    end
  end

  def close
  end

end

class OrganoInternosDestination
  def initialize(results:, verbose:)
    @verbose = verbose
    @results = results
    @organo_internos_errors = 0
    @new_organo_internos = 0
    @found_organo_internos = 0
  end

  #nombre_desde_el_modelo: row[:nombre_desde_headers]
  def write(row)
  organo_interno = OrganoInterno.where(partido_id: row[:partido_id],
                                         nombre: row[:unidades_u_rganos_internos],
                                         funciones: row[:facultades_funciones_y_atribuciones]).first_or_initialize
  trimestre_informado = TrimestreInformado.find(row[:trimestre_informado_id]) unless row[:trimestre_informado_id].nil?

    if organo_interno.id.nil?
      organo_interno.save
      if organo_interno.errors.any?
        #p organo_interno.errors
        row[:error_log] = row[:error_log].to_s + ', ' + organo_interno.errors.messages.to_s
        @organo_internos_errors = @organo_internos_errors + 1
      else
        unless trimestre_informado.nil?
          organo_interno.trimestre_informados << trimestre_informado unless trimestre_informado.in?(organo_interno.trimestre_informados)
        end
        @new_organo_internos = @new_organo_internos + 1
      end
    else
      unless trimestre_informado.nil?
        organo_interno.trimestre_informados << trimestre_informado unless trimestre_informado.in?(organo_interno.trimestre_informados)
      end
    @found_organo_internos = @found_organo_internos + 1
    end
  end

  def close
  @results[:organo_internos] = {:new_organo_internos => @new_organo_internos,
    :organo_internos_errors => @organo_internos_errors,
    :found_organo_internos => @found_organo_internos}
  end
end

class CargosDestination
  def initialize(results:, verbose:)
    @verbose = verbose
    @results = results
    @cargos_errors = 0
    @new_cargos = 0
    @found_cargos = 0
  end

  #nombre_desde_el_modelo: row[:nombre_desde_headers]
  def write(row)

    if !row[:organo_interno_id].nil?
      cargo = Cargo.where(partido_id: row[:partido_id],
                          persona_id: row[:persona_id],
                          organo_interno_id: row[:organo_interno_id],
                          tipo_cargo_id: row[:tipo_cargo_id]).first_or_initialize
    else
      cargo = Cargo.where(partido_id: row[:partido_id],
                          persona_id: row[:persona_id],
                          comuna_id: row[:comuna_id],
                          tipo_cargo_id: row[:tipo_cargo_id]).first_or_initialize
    end
    trimestre_informado = TrimestreInformado.find(row[:trimestre_informado_id])

    # if (row[:organo_interno_id] || row[:comuna_id]).nil?
    #   row[:error_log] = row[:error_log].to_s + 'Cannot save Cargo without Organo Interno, ' + cargo.errors.messages.to_s
    #   @cargos_errors = @cargos_errors + 1
    # else
      if cargo.id.nil?
        cargo.save
        if cargo.errors.any?
          row[:error_log] = row[:error_log].to_s + ', ' + cargo.errors.messages.to_s
          @cargos_errors = @cargos_errors + 1
        else
          cargo.trimestre_informados << trimestre_informado unless trimestre_informado.in?(cargo.trimestre_informados)
          @new_cargos = @new_cargos + 1
        end
      else
        cargo.trimestre_informados << trimestre_informado unless trimestre_informado.in?(cargo.trimestre_informados)
        @found_cargos = @found_cargos + 1
      end
    # end
  end

  def close
    @results[:cargos] = { :new_cargos => @new_cargos ,
                          :cargos_errors => @cargos_errors,
                          :found_cargos => @found_cargos }
  end
end

class IngresoOrdinarioDestination
  def initialize(results:, verbose:)
    @verbose = verbose
    @results = results
    @new = 0
    @errors = 0
    @found = 0
  end

  def write(row)

    concepto = clean_phrase(row[:item])
    ingreso_ordinario = IngresoOrdinario.where(partido_id: row[:partido_id],
                                               concepto: concepto,
                                               importe: clean_number(row[:monto])).first_or_initialize

    trimestre_informado = TrimestreInformado.find(row[:trimestre_informado_id])

    if ingreso_ordinario.id.nil?
      ingreso_ordinario.save
      if ingreso_ordinario.errors.any?
        row[:error_log] = row[:error_log].to_s + ', ' + ingreso_ordinario.errors.messages.to_s
        @results[:ingreso_ordinarios][:errors] += 1
      else
        ingreso_ordinario.trimestre_informados << trimestre_informado unless trimestre_informado.in?(ingreso_ordinario.trimestre_informados)
        @results[:ingreso_ordinarios][:new] += 1
      end
    else
      ingreso_ordinario.trimestre_informados << trimestre_informado unless trimestre_informado.in?(ingreso_ordinario.trimestre_informados)
      @results[:ingreso_ordinarios][:found] += 1
    end
  end

  def close
    @results[:ingreso_ordinarios] = {new: @results[:ingreso_ordinarios][:new],
                       errors: @results[:ingreso_ordinarios][:errors],
                       found: @results[:ingreso_ordinarios][:found]}
  end
end

class ContratacionDestination
  def initialize(results:, verbose:)
    @verbose = verbose
    @results = results
    @new = 0
    @errors = 0
    @found = 0
  end

  def write(row)

    fecha_inicio, handler = vali_date(row[:fecha_de_inicio_del_contrato], handler) unless row[:fecha_de_inicio_del_contrato].nil?
    fecha_termino, handler = vali_date(row[:fecha_de_trmino_del_contrato], handler) unless row[:fecha_de_trmino_del_contrato].nil?
    if handler != nil
      row[:error_log] = row[:error_log].to_s + handler
      @results[:contratacions][:errors] += 1
    end

    contratacion = Contratacion.where(partido_id: row[:partido_id],
                                    individualizacion: row[:individualizacin_del_contrato],
                                    razon_social: row[:contratista],
                                    rut: row[:rut],
                                    titulares: row[:socios_o_accionistas],
                                    descripcion: row[:objeto_de_la_contratacin],
                                    monto: row[:monto],
                                    fecha_inicio: fecha_inicio,
                                    fecha_termino: fecha_termino,
                                    link: row[:link_al_contrato]).first_or_initialize

    trimestre_informado = TrimestreInformado.find(row[:trimestre_informado_id])

    if contratacion.id.nil?
      contratacion.save
      if contratacion.errors.any?
        row[:error_log] = row[:error_log].to_s + ', ' + contratacion.errors.messages.to_s
        @results[:contratacions][:errors] += 1
      else
        contratacion.trimestre_informados << trimestre_informado unless trimestre_informado.in?(contratacion.trimestre_informados)
        @results[:contratacions][:new] += 1
      end
    else
      contratacion.trimestre_informados << trimestre_informado unless trimestre_informado.in?(contratacion.trimestre_informados)
      @results[:contratacions][:found] += 1
    end
  end

  def close
    @results[:contratacions] = {new: @results[:contratacions][:new],
                                 errors: @results[:contratacions][:errors],
                                 found: @results[:contratacions][:found]}
  end
end

class EgresoCampanaDestination
  def initialize(results:, verbose:)
    @verbose = verbose
    @results = results
    @new = 0
    @errors = 0
    @found = 0
    @last_egresocampana = EgresoCampana.last
    @count_initial = EgresoCampana.count
    @trimestres = []
    @partidos = []
  end

  def write(row)

    trimestre_informado = TrimestreInformado.find(row[:trimestre_informado_id])

    @partidos << row[:partido_id] unless row[:partido_id].in?(@partidos)

    monto = clean_number(row[:monto])
    egreso_campana = EgresoCampana.new(partido_id: row[:partido_id],
                                         tipo_campana: row[:tipo_de_campaa],
                                         item: row[:item],
                                         monto: monto,
                                         estado: row[:estado])

    if egreso_campana.id.nil?
      egreso_campana.save
      if egreso_campana.errors.any?
        row[:error_log] = row[:error_log].to_s + ', ' + egreso_campana.errors.messages.to_s
        @results[:egreso_campanas][:errors] += 1
      else
        egreso_campana.trimestre_informados << trimestre_informado unless trimestre_informado.in?(egreso_campana.trimestre_informados)
        @trimestres << trimestre_informado unless trimestre_informado.in?(@trimestres)
        @results[:egreso_campanas][:new] += 1
      end
    else
      egreso_campana.trimestre_informados << trimestre_informado unless trimestre_informado.in?(egreso_campana.trimestre_informados)
      @trimestres << trimestre_informado unless trimestre_informado.in?(@trimestres)
      @results[:egreso_campanas][:found] += 1
    end
  end

  def close
    @results[:egreso_campanas] = {new: @results[:egreso_campanas][:new],
                                 errors: @results[:egreso_campanas][:errors],
                                 found: @results[:egreso_campanas][:found]}
    p @count_initial
    p EgresoCampana.count
    if @last_egresocampana
      if @last_egresocampana.id != nil
        @trimestres.map{|ec| ec.egreso_campanas.where("id <= ?", @last_egresocampana.id).where(:partido_id => @partidos.compact).destroy_all}
      end
  end
    p EgresoCampana.count

  end
end

class EgresoOrdinarioDestination
  def initialize(results:, verbose:)
    @verbose = verbose
    @results = results
    @new = 0
    @errors = 0
    @found = 0
    @last_egresoordinario = EgresoOrdinario.last unless EgresoOrdinario.nil?
    @count_initial = EgresoOrdinario.count
    @trimestres = []
    @partidos = []
    @conceptos = []
    @partidos_id = []
    @contador = 0
  end

  def write(row)

    trimestre_informado = TrimestreInformado.find(row[:trimestre_informado_id])

    @partidos << row[:partido_id] unless row[:partido_id].in?(@partidos)

    concepto = clean_phrase(row[:item_de_gastos])
    enero = clean_number(row[:enero])
    febrero = clean_number(row[:febrero])
    marzo = clean_number(row[:marzo])
    abril = clean_number(row[:abril])
    mayo = clean_number(row[:mayo])
    junio = clean_number(row[:junio])
    julio = clean_number(row[:julio])
    agosto = clean_number(row[:agosto])
    septiembre = clean_number(row[:septiembre])
    octubre = clean_number(row[:octubre])
    noviembre = clean_number(row[:noviembre])
    diciembre = clean_number(row[:diciembre])

    egreso_ordinario = EgresoOrdinario.new(partido_id: row[:partido_id],
                                         concepto: concepto,
                                         enero: enero,
                                         febrero: febrero,
                                         marzo: marzo,
                                         abril: abril,
                                         mayo: mayo,
                                         junio: junio,
                                         julio: julio,
                                         agosto: agosto,
                                         septiembre: septiembre,
                                         octubre: octubre,
                                         noviembre: noviembre,
                                         diciembre: diciembre)



    # if (egreso_ordinario.partido_id.in?(@partidos_id) && egreso_ordinario.concepto.in?(@conceptos) && trimestre_informado.in?(@trimestres))
    #   p 'IH' + @contador.to_s
    #   @contador += 1
    # end
    if egreso_ordinario.id.nil?
      egreso_ordinario.save
      if egreso_ordinario.errors.any?
        row[:error_log] = row[:error_log].to_s + ', ' + egreso_ordinario.errors.messages.to_s
        @results[:egreso_ordinarios][:errors] += 1
      else
        egreso_ordinario.trimestre_informados << trimestre_informado unless trimestre_informado.in?(egreso_ordinario.trimestre_informados)
        @trimestres << trimestre_informado unless trimestre_informado.in?(@trimestres)
        @results[:egreso_ordinarios][:new] += 1
      end
    else
      egreso_ordinario.trimestre_informados << trimestre_informado unless trimestre_informado.in?(egreso_ordinario.trimestre_informados)
      @trimestres << trimestre_informado unless trimestre_informado.in?(@trimestres)
      @results[:egreso_ordinarios][:found] += 1
    end
    @partidos_id << egreso_ordinario.partido_id
    @conceptos << egreso_ordinario.concepto
  end

  def close
    @results[:egreso_ordinarios] = {new: @results[:egreso_ordinarios][:new],
                                 errors: @results[:egreso_ordinarios][:errors],
                                 found: @results[:egreso_ordinarios][:found]}
    p @count_initial
    p EgresoOrdinario.count
    if @last_egresoordinario
      if @last_egresoordinario.id != nil
        @trimestres.map{|ec| ec.egreso_ordinarios.where("id <= ?", @last_egresoordinario.id).where(:partido_id => @partidos.compact).destroy_all}
      end
    end
    p EgresoOrdinario.count

  end
end

class IngresoCampanaDestination
  def initialize(results:, verbose:)
    @verbose = verbose
    @results = results
    @new = 0
    @errors = 0
    @found = 0
    @last_ingresocampana = IngresoCampana.last
    @count_initial =IngresoCampana.count
    @trimestres = []
    @partidos = []
  end

  def write(row)

    trimestre_informado = TrimestreInformado.find(row[:trimestre_informado_id])

    @partidos << row[:partido_id] unless row[:partido_id].in?(@partidos)

    monto = clean_number(row[:valorizacin_en_pesos])
    ingreso_campana = IngresoCampana.new(partido_id: row[:partido_id],
                                         nombre_donante: row[:persona_efecta_aporte].titleize,
                                         tipo_aporte: row[:tipo_de_aporte],
                                         monto: monto)


    if ingreso_campana.id.nil?
      ingreso_campana.save
      if ingreso_campana.errors.any?
        row[:error_log] = row[:error_log].to_s + ', ' + ingreso_campana.errors.messages.to_s
        @results[:ingreso_campanas][:errors] += 1
      else
        ingreso_campana.trimestre_informados << trimestre_informado unless trimestre_informado.in?(ingreso_campana.trimestre_informados)
        @trimestres << trimestre_informado unless trimestre_informado.in?(@trimestres)
        @results[:ingreso_campanas][:new] += 1
      end
    else
      ingreso_campana.trimestre_informados << trimestre_informado unless trimestre_informado.in?(ingreso_campana.trimestre_informados)
      @trimestres << trimestre_informado unless trimestre_informado.in?(@trimestres)
      @results[:ingreso_campanas][:found] += 1
    end
  end

  def close
    @results[:ingreso_campanas] = {new: @results[:ingreso_campanas][:new],
                                 errors: @results[:ingreso_campanas][:errors],
                                 found: @results[:ingreso_campanas][:found]}
    p @count_initial
    p IngresoCampana.count
    if @last_ingresocampana
      if @last_ingresocampana.id != nil
        @trimestres.map{|ic| ic.ingreso_campanas.where("id <= ?", @last_ingresocampana.id).where(:partido_id => @partidos.compact).destroy_all}
      end
  end
    p IngresoCampana.count

  end
end

class TransferenciaDestination
  def initialize(results:, verbose:)
    @verbose = verbose
    @results = results
    @new = 0
    @errors = 0
    @found = 0
    @last_transferencia = Transferencia.last unless Transferencia.nil?
    @count_initial = Transferencia.count
    @trimestres = []
    @partidos = []
  end
  #nombre_desde_el_modelo: row[:nombre_desde_headers]
  def write(row)

    trimestre_informado = TrimestreInformado.find(row[:trimestre_informado_id])

    @partidos << row[:partido_id] unless row[:partido_id].in?(@partidos)


    fecha = row[:fecha_transferencia].to_date unless row[:fecha_transferencia].nil?
    transferencia = Transferencia.new(partido_id: row[:partido_id],
                                        # fecha: row[:fecha_transferencia].to_date unless row[:fecha_transferencia].nil?,
                                        fecha: fecha,
                                        monto: clean_number(row[:monto]),
                                        descripcion: row[:objeto_de_la_transferencia],
                                        razon_social: row[:persona_jurdica_receptora],
                                        rut: row[:rut_persona_jurdica],
                                        persona_natural: row[:persona_natural_receptora].downcase.titleize)

    if transferencia.id.nil?
      transferencia.save
      if transferencia.errors.any?
        row[:error_log] = row[:error_log].to_s + ', ' + transferencia.errors.messages.to_s
        @results[:transferencias][:errors] += 1
      else
        transferencia.trimestre_informados << trimestre_informado unless trimestre_informado.in?(transferencia.trimestre_informados)
        @trimestres << trimestre_informado unless trimestre_informado.in?(@trimestres)
        @results[:transferencias][:new] += 1
      end
    else
      transferencia.trimestre_informados << trimestre_informado unless trimestre_informado.in?(transferencia.trimestre_informados)
      @trimestres << trimestre_informado unless trimestre_informado.in?(@trimestres)
      @results[:transferencias][:found] += 1
    end
  end

  def close
    @results[:transferencias] = {new: @results[:transferencias][:new],
                       errors: @results[:transferencias][:errors],
                       found: @results[:transferencias][:found]}
    p @count_initial
    p Transferencia.count
    if @last_transferencia
      if @last_transferencia.id != nil
        @trimestres.map{|t| t.transferencias.where("id <= ?", @last_transferencia.id).where(:partido_id => @partidos.compact).destroy_all}
      end
  end
    p Transferencia.count

  end
end

class SancionDestination
  def initialize(results:, verbose:)
    @verbose = verbose
    @results = results
    @new = 0
    @errors = 0
    @found = 0
  end

  def write(row)

    trimestre_informado = TrimestreInformado.find(row[:trimestre_informado_id])

    fecha_de_resolucin, handler = vali_date(row[:fecha_de_resolucin], handler) unless row[:fecha_de_resolucin].nil?
    if handler != nil
      row[:error_log] = row[:error_log].to_s + handler
      @results[:sancions][:errors] += 1
    end

    link_resolucion = validate_url(row[:vnculo_a_la_resolucin])

    sancion = Sancion.where(partido_id: row[:partido_id],
                            fecha: fecha_de_resolucin,
                            descripcion: row[:infraccin_cometida],
                            tipo_sancion: row[:tipo_de_sancin],
                            link_resolucion: link_resolucion).first_or_initialize

    if sancion.id.nil?
      sancion.save
      if sancion.errors.any?
        row[:error_log] = row[:error_log].to_s + ', ' + sancion.errors.messages.to_s
        @results[:sancions][:errors] += 1
      else
        sancion.trimestre_informados << trimestre_informado unless trimestre_informado.in?(sancion.trimestre_informados)
        @results[:sancions][:new] += 1
      end
    else
      sancion.trimestre_informados << trimestre_informado unless trimestre_informado.in?(sancion.trimestre_informados)
      @results[:sancions][:found] += 1
    end
  end

  def close
    @results[:sancions] = {new: @results[:sancions][:new],
                                 errors: @results[:sancions][:errors],
                                 found: @results[:sancions][:found]}
  end

end



class AfiliacionDestination
  def initialize(results:, verbose:)
    @verbose = verbose
    @results = results
    @new = 0
    @errors = 0
    @found = 0
  end

  def write(row)

    # total_afiliados = clean_number(row[:nmero_total_de_afiliados])
    # afiliacion = Afiliacion.where(partido_id: row[:partido_id],
    #                               otros: total_afiliados).first_or_initialize
    trimestre_informado = TrimestreInformado.find(row[:trimestre_informado_id])
    cantidad_mujeres = clean_number(row[:n_mujeres])
    cantidad_hombres = clean_number(row[:n_hombres])
    total_afiliados = clean_number(row[:total])

    if row[:total_y_rango_etario] == 'Total Militantes'
      afiliacion = Afiliacion.where(partido_id: row[:partido_id],
                                    rango_etareo: row[:total_y_rango_etario],
                                    mujeres: cantidad_mujeres,
                                    porcentaje_mujeres: row[:_mujeres],
                                    hombres: cantidad_hombres,
                                    porcentaje_hombres: row[:_hombres],
                                    total_afiliados: total_afiliados).first_or_initialize
    else
      afiliacion = Afiliacion.where(partido_id: row[:partido_id],
                                    rango_etareo: row[:total_y_rango_etario],
                                    mujeres: cantidad_mujeres,
                                    porcentaje_mujeres: row[:_mujeres],
                                    hombres: cantidad_hombres,
                                    porcentaje_hombres: row[:_hombres]).first_or_initialize
    end

    if afiliacion.id.nil?
      afiliacion.save
      if afiliacion.errors.any?
        row[:error_log] = row[:error_log].to_s + ', ' + afiliacion.errors.messages.to_s
        @results[:afiliacions][:errors] += 1
      else
        afiliacion.trimestre_informados << trimestre_informado unless trimestre_informado.in?(afiliacion.trimestre_informados)
        @results[:afiliacions][:new] += 1
      end
    else
      afiliacion.trimestre_informados << trimestre_informado unless trimestre_informado.in?(afiliacion.trimestre_informados)
      # p afiliacion.partido_id.to_s
      # p afiliacion.mujeres.to_s
      # p afiliacion.hombres.to_s
      @results[:afiliacions][:found] += 1
    end
  end

  def close
    @results[:afiliacions] = {new: @results[:afiliacions][:new],
                                 errors: @results[:afiliacions][:errors],
                                 found: @results[:afiliacions][:found]}
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
