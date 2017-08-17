class ComparisonsController < ApplicationController
  #before_action :set_comparison, only: [:show, :edit, :update, :destroy]
  before_action :set_comparison_params
  layout "comparison"
  include ComparisonsHelper

  # GET /comparisons
  # GET /comparisons.json
  def index
    @partidos = Partido.select(:id, :nombre, :sigla)
    i = categories.index @category

    case i
      when 1
        afiliados_x_edad

      when 3
        cargos

      when 2
        regions

      else
        regions

    end
  end

  private

    def afiliados
      @fechas_datos = Afiliacion.where(Afiliacion.arel_table[:partido_id].in(@partido_ids)).uniq.pluck(:fecha_datos).sort

      @regiones_datos = Afiliacion.joins(:region).where(Afiliacion.arel_table[:partido_id].in(@partido_ids)).uniq.pluck(:nombre, :region_id).sort

      @datos = []
      @partido_ids.each do |p_id|
        partido = Partido.find p_id

        if @fecha_param.nil?
          @fecha = @fechas_datos.last
        else
          @fecha = @fecha_param
        end

        afiliados = Afiliacion.where(partido: partido, fecha_datos: @fecha)
        if !params["region"].blank?
          afiliados = afiliados.where(region_id: params["region"])
        end
        h = 0 #hombres
        m = 0 #mujeres
        afiliados.each do |a|
          h = h + a.hombres
          m = m + a.mujeres
        end
        total_generos = h + m
        if !params[:genero].blank?
          case params[:genero]
            when 'hombres'
              total_generos = h
              m = 0

            when 'mujeres'
              total_generos = m
              h = 0

          end
        end
        missing_data = total_generos.nil?
        @datos << {:nombre => partido.nombre, :partido_id => partido.id, :total => total_generos,
                   :hombres => h, :mujeres => m, :missing_data => missing_data }
      end

      @max_value = @datos.map {|d| d[:total] || 0}.max


      render "num_afiliados"
    end

    def afiliados_x_edad
      rangos = rangos_etarios

      temp_trimestres_informados = []
      Afiliacion.where(partido_id: @partido_ids).all.map{|a| temp_trimestres_informados.concat(a.trimestre_informado_ids)}
      @trimestres_informados = TrimestreInformado.find(temp_trimestres_informados.uniq.sort!)
      @trimestres_informados = @trimestres_informados.sort_by {|t| t.ano.to_s + t.ordinal.to_s}.reverse!

      params[:trimestre_informado_id] = @trimestres_informados.first.id if params[:trimestre_informado_id].nil?
      @trimestre_informado = TrimestreInformado.find(params[:trimestre_informado_id])

      @filtro_genero = params[:genero].to_s

      @datos = []
      # @partido_ids.each do |p_id|
      #   partido = Partido.find p_id
      # end
      # p "partido_ids " + @partido_ids.to_s
      @partido_ids = @partido_ids.each.sort{|p| @trimestre_informado.afiliacions.where(partido_id: p).count}.reverse
      # p @partido_ids


        @afiliados = @trimestre_informado.afiliacions.where(:partido_id => @partido_ids)
        #last_date = Afiliacion.where(partido: partido).uniq.pluck(:fecha_datos).sort.last

      #   if @fecha_param.nil?
      #     @fecha = @fechas_datos.last
      #   else
      #     @fecha = @fecha_param
      #   end
      #
      #   afiliados = Afiliacion.where(partido: partido, fecha_datos: @fecha)
      #   if !params["region"].blank?
      #     afiliados = afiliados.where(region_id: params["region"])
      #   end
      #   h = 0 #hombres
      #   m = 0 #mujeres
      #   afiliados.each do |a|
      #     h = h + a.hombres
      #     m = m + a.mujeres
      #   end
      #   tramos = []
      #   if (h > 0 || m > 0)
      #     rangos.each do |rango|
      #       participantes = afiliados.where(:ano_nacimiento => Date.today.year-rango[1]..Date.today.year-rango[0])
      #       ph = 0 #participantes hombres
      #       pm = 0 #participantes mujeres
      #       participantes.each do |np|
      #         ph = ph + np.hombres
      #         pm = pm + np.mujeres
      #       end
      #       num_generos = ph + pm
      #       if !params[:genero].blank?
      #         case params[:genero]
      #           when 'hombres'
      #             num_generos = ph
      #
      #           when 'mujeres'
      #             num_generos = pm
      #
      #         end
      #       end
      #       tramos << {:tramo => rango, :count => num_generos}
      #     end
      #   end
      #
      #   total_generos = h + m
      #   if !params[:genero].blank?
      #     case params[:genero]
      #       when 'hombres'
      #         total_generos = h
      #       when 'mujeres'
      #         total_generos = m
      #     end
      #   end
      #   @datos << {:partido => partido.nombre, :partido_id => partido.id, :tramos => tramos, :total => total_generos}
      # end
      #
      # @max_total = @datos.map{|p| p[:total]}.max

      @regiones = Region.all

      p @filtro_genero

      render "afiliados_x_edad"
    end

    def cargos

      temp_trimestres_informados = []
      EstadisticaCargo.where(partido_id: @partido_ids).all.map{|a| temp_trimestres_informados.concat(a.trimestre_informado_ids)}
      @trimestres_informados = TrimestreInformado.find(temp_trimestres_informados.uniq.sort!)
      @trimestres_informados = @trimestres_informados.sort_by {|t| t.ano.to_s + t.ordinal.to_s}.reverse!

      params[:trimestre_informado_id] = @trimestres_informados.first.id if params[:trimestre_informado_id].nil?
      @trimestre_informado = TrimestreInformado.find(params[:trimestre_informado_id])

      @filtro_genero = params[:genero].to_s

      @datos = []

      @partido_ids = @partido_ids.each.sort{|p| @trimestre_informado.estadistica_cargos.where(partido_id: p).count}.reverse


      @cargos = @trimestre_informado.estadistica_cargos.where(:partido_id => @partido_ids)

      @cargos.each do |c|
        p c
      end

      @regiones = Region.all

      p @filtro_genero

      render "cargos"
    end

    def regions
      @datos = []
      @partido_ids.each do |partido_id|
        partido = Partido.find partido_id
        regions_ordinals = partido.regions.map {|r| r.ordinal}

        regions_map = []
        (1..15).each do |ordinal|
          regions_map << regions_ordinals.include?(ordinal.to_s) ? true : false
        end

        @datos << {:nombre => partido.nombre, :partido_id => partido.id, :sigla =>partido.sigla, :mapa => regions_map}
      end

      render "regions"
    end

    def ingresos_ordianrios
      @datos = []

      @fechas_datos = IngresoOrdinario.where(IngresoOrdinario.arel_table[:partido_id].in(@partido_ids)).uniq.pluck(:fecha_datos).sort

      if @fecha_param.nil?
        @fecha = @fechas_datos.last
      else
        @fecha = @fecha_param
      end


      @datos_publicos = Partido.joins('left join ingreso_ordinarios on ingreso_ordinarios.partido_id = partidos.id and ingreso_ordinarios.fecha_datos in (\'' + @fecha.to_s + '\')')
      .where(Partido.arel_table[:id].in(@partido_ids))
      .where(IngresoOrdinario.arel_table[:concepto].eq('Aportes Estatales').or(IngresoOrdinario.arel_table[:concepto].eq(nil)))
      .where(IngresoOrdinario.arel_table[:fecha_datos].in(@fecha).or(IngresoOrdinario.arel_table[:fecha_datos].eq(nil)))
      .select(Partido.arel_table[:sigla],Partido.arel_table[:nombre], "fecha_datos, partido_id, sum(importe) as total_publico")
      .group(IngresoOrdinario.arel_table[:fecha_datos], Partido.arel_table[:id], IngresoOrdinario.arel_table[:partido_id])
      .order(Partido.arel_table[:id])

      @datos_privados = Partido.joins('left join ingreso_ordinarios on ingreso_ordinarios.partido_id = partidos.id and ingreso_ordinarios.fecha_datos in (\'' + @fecha.to_s + '\')')
      .where(Partido.arel_table[:id].in(@partido_ids))
      .where(IngresoOrdinario.arel_table[:concepto].not_eq('Aportes Estatales').or(IngresoOrdinario.arel_table[:concepto].eq(nil)))
      .where(IngresoOrdinario.arel_table[:fecha_datos].in(@fecha).or(IngresoOrdinario.arel_table[:fecha_datos].eq(nil)))
      .select(Partido.arel_table[:sigla],Partido.arel_table[:nombre], "fecha_datos, partido_id, sum(importe) as total_privado")
      .group(IngresoOrdinario.arel_table[:fecha_datos], Partido.arel_table[:id], IngresoOrdinario.arel_table[:partido_id])
      .order(Partido.arel_table[:id])

      @datos_privados.each_with_index do |d, i|
        missing_data = @datos_privados[i].total_privado.nil? or @datos_publicos[i].total_publico.nil?
        @datos << {:nombre => @datos_privados[i].nombre.to_s, :partido_id => @datos_privados[i].partido_id.to_s, :sigla => @datos_privados[i].sigla.to_s,
           :total_privado => @datos_privados[i].total_privado, :total_publico => @datos_publicos[i].total_publico, :missing_data => missing_data }
      end

      render "ingresos_ord"
    end

    def representantes
      @datos =[]
      @partido_ids.each do |p_id|
        partido = Partido.find p_id
        tipos_cargo = partido.tipo_cargos.where :representante => true
        if !params["tipo_cargo"].blank?
          tipos_cargo = tipos_cargo.where(titulo: params["tipo_cargo"])
        end
        cargos = partido.cargos.where :tipo_cargo => tipos_cargo
        if !params["region"].blank?
          cargos = cargos.where(region_id: params["region"])
        end
        cargos_ids_array = cargos.map{|c| c.tipo_cargo_id}.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
        cargos_count = cargos_ids_array.transform_keys{|key| TipoCargo.find(key).titulo}
        @datos << {:partido => {:sigla => partido.sigla, :partido_id => partido.id}, :representantes => cargos_count.to_a }
      end

      @max_number = @datos.map{|r| r[:representantes].map{|c| c[1]}.max}.compact.max

      @regiones = Region.all
      @tipo_cargos = TipoCargo.where(:representante => true).pluck(:titulo).uniq



      # query_r = Partido.joins('left join tipo_cargos tc on tc.partido_id = partidos.id and tc.representante = true left join cargos c on c.tipo_cargo_id = tc.id ')
      # .where(Partido.arel_table[:id].in(@partido_ids))
      # .select('partidos.id, partidos.sigla, tc.titulo, count(c.id) as count')
      # .group('partidos.id, tc.id')
      # .order('partidos.id, tc.id')
      #
      # partidos = query_r.map{|l| l.sigla}.uniq
      # keys = ['titulo', 'count']
      # @datos =[]
      # partidos.map do |p|
      #   r = query_r.select{|r| r[:sigla] == p }
      #   s = r.select{|r| r[:region_id] == 1}
      #   @datos << {:partido => {:sigla => p} , :representantes => r.map{|h| Hash[keys.zip(h.attributes.values_at(*keys))]} }
      # end
      #
      # @max_number = @datos.map{|r| r[:representantes].map{|c| c['count']}.max}.max
      #
      # @fechas_datos = []
      # @regiones_datos = []

      render "representantes"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comparison_params
      @partido_ids = params[:partido_ids].nil? ? Partido.ids : params[:partido_ids]
      @category = params[:category].nil? ? 'category_1' : params[:category]
      @fecha_param = params[:fecha_datos].blank? ? nil : Date.new(params[:fecha_datos].split("-")[0].to_i, params[:fecha_datos].split("-")[1].to_i, params[:fecha_datos].split("-")[2].to_i)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comparison_params
      params.fetch(:comparison, {})
    end

end
