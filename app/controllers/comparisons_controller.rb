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
        puts "case"
      else
        afiliados

    end
  end

  private

    def afiliados
      puts "compartiva de afiliados"
      #datos = Afiliacion.where('partido_id IN (?)', @partido_ids).select('partido_id, sum(hombres) as hombres, sum(mujeres) as mujeres, sum(otros) as otros').group(:partido_id)
      @datos = Afiliacion.joins(:partido).where(Afiliacion.arel_table[:partido_id].in(@partido_ids)).select(Partido.arel_table[:sigla],Partido.arel_table[:nombre], 'partido_id, sum(hombres) as hombres, sum(mujeres) as mujeres, sum(otros) as otros').group(Partido.arel_table[:id], Afiliacion.arel_table[:partido_id])
      @fechas_datos = Afiliacion.where(Afiliacion.arel_table[:partido_id].in(@partido_ids)).uniq.pluck(:fecha_datos).sort
      @regiones_datos = Afiliacion.joins(:region).where(Afiliacion.arel_table[:partido_id].in(@partido_ids)).uniq.pluck(:nombre, :region_id).sort
      @fecha = @fechas_datos.last
      render "num_afiliados"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comparison_params
      @partido_ids = params[:partido_ids].nil? ? Partido.ids : params[:partido_ids]
      @category = params[:category].nil? ? 'category_1' : params[:category]
      # puts "Comparing partidos with id: " + @partido_ids.join(',')
      # puts "Category: " + @category
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comparison_params
      params.fetch(:comparison, {})
    end

end
