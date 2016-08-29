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
      else
        afiliados

    end
  end

  private

    def afiliados
      puts "compartiva de afiliados"
      @fechas_datos = Afiliacion.where(Afiliacion.arel_table[:partido_id].in(@partido_ids)).uniq.pluck(:fecha_datos).sort

      @regiones_datos = Afiliacion.joins(:region).where(Afiliacion.arel_table[:partido_id].in(@partido_ids)).uniq.pluck(:nombre, :region_id).sort

      if @fecha_param.nil?
        @fecha = @fechas_datos.last
      else
        @fecha = @fecha_param
      end

      @datos = Afiliacion.joins(:partido).where(Afiliacion.arel_table[:partido_id].in(@partido_ids))
      .where(Afiliacion.arel_table[:fecha_datos].in(@fecha))
      .select(Partido.arel_table[:sigla],Partido.arel_table[:nombre], 'fecha_datos, partido_id, sum(hombres) as hombres, sum(mujeres) as mujeres, sum(otros) as otros, (sum(hombres) + sum(mujeres)) as total')
      .group(Afiliacion.arel_table[:fecha_datos], Partido.arel_table[:id], Afiliacion.arel_table[:partido_id])


      #max_sum = ActiveRecord::Base.connection.select('SUM(hombres + mujeres) as total').from(@datos).order('total DESC').first
      #max_sum = Afiliacion.select('hombres, mujeres').from(@datos).order('hombres + mujeres DESC').first
      # sql = "SELECT * from admins limit 10"
      # result = ActiveRecord::Base.connection.execute(sql)
      # puts result.to_a
      totals = @datos.map {|d| d.total}

      puts totals.max

      @datos_totales = [{ :max_value => totals.max}]

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

        @datos << {:nombre => partido.nombre, :sigla =>partido.sigla, :map => regions_map}
      end

      render "regions"
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_comparison_params
      @partido_ids = params[:partido_ids].nil? ? Partido.ids : params[:partido_ids]
      @category = params[:category].nil? ? 'category_1' : params[:category]
      @fecha_param = params[:fecha_datos].nil? ? nil : Date.new(params[:fecha_datos].split("-")[0].to_i, params[:fecha_datos].split("-")[1].to_i, params[:fecha_datos].split("-")[2].to_i)
      # puts "Comparing partidos with id: " + @partido_ids.join(',')
      # puts "Category: " + @category
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comparison_params
      params.fetch(:comparison, {})
    end

end
