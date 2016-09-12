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
    puts "i: " + i.to_s
    case i
      when 1
        regions

      when 2
        ingresos_ordianrios

      when 3
        representantes

      else
        afiliados

    end
  end

  private

    def afiliados
      @fechas_datos = Afiliacion.where(Afiliacion.arel_table[:partido_id].in(@partido_ids)).uniq.pluck(:fecha_datos).sort

      @regiones_datos = Afiliacion.joins(:region).where(Afiliacion.arel_table[:partido_id].in(@partido_ids)).uniq.pluck(:nombre, :region_id).sort

      if @fecha_param.nil?
        @fecha = @fechas_datos.last
      else
        @fecha = @fecha_param
      end

      @datos = Partido.joins('left join afiliacions on afiliacions.partido_id = partidos.id and afiliacions.fecha_datos in (\'' + @fecha.to_s + '\')')
      .where(Partido.arel_table[:id].in(@partido_ids))
      .select(Partido.arel_table[:sigla],Partido.arel_table[:nombre], 'fecha_datos, partido_id, sum(hombres) as hombres, sum(mujeres) as mujeres, sum(otros) as otros, (sum(hombres) + sum(mujeres)) as total')
      .group(Afiliacion.arel_table[:fecha_datos], Partido.arel_table[:id], Afiliacion.arel_table[:partido_id])

      #   @datos =[]
      #
      # @datos_query.each do |d|
      #   puts d
      #   missing_data = d['total'].nil?
      #   @datos << {:nombre => d.nombre.to_s, :sigla =>d.sigla.to_s, :total => d['total'],
      #      :hombres => d['hombres'], :mujeres => d['mujeres'], :missing_data => missing_data }
      # end

      totals = @datos.map {|d| d.total || 0}
      @datos_totals = [{ :max_value => totals.max}]


      render "num_afiliados"
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

        @datos << {:nombre => partido.nombre, :sigla =>partido.sigla, :mapa => regions_map}
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
        @datos << {:nombre => @datos_privados[i].nombre.to_s, :sigla => @datos_privados[i].sigla.to_s,
           :total_privado => @datos_privados[i].total_privado, :total_publico => @datos_publicos[i].total_publico, :missing_data => missing_data }
      end

      render "ingresos_ord"
    end

    def representantes
      query_r = Partido.joins('left join tipo_cargos tc on tc.partido_id = partidos.id and tc.representante = true left join cargos c on c.tipo_cargo_id = tc.id ')
      .where(Partido.arel_table[:id].in(@partido_ids))
      .select('partidos.id, partidos.sigla, tc.titulo, count(c.id) as count')
      .group('partidos.id, tc.id')
      .order('partidos.id, tc.id')

      partidos = query_r.map{|l| l.sigla}.uniq
      keys = ['titulo', 'count']
      @datos =[]
      partidos.map do |p|
        r =  query_r.select{|r| r[:sigla] == p }

        @datos << {:partido => {:sigla => p} , :representantes => r.map{|h| Hash[keys.zip(h.attributes.values_at(*keys))]} }
      end

      @fechas_datos = []
      @regiones_datos = []

      render "representantes"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comparison_params
      @partido_ids = params[:partido_ids].nil? ? Partido.ids : params[:partido_ids]
      @category = params[:category].nil? ? 'category_1' : params[:category]
      @fecha_param = params[:fecha_datos].nil? ? nil : Date.new(params[:fecha_datos].split("-")[0].to_i, params[:fecha_datos].split("-")[1].to_i, params[:fecha_datos].split("-")[2].to_i)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comparison_params
      params.fetch(:comparison, {})
    end

end
