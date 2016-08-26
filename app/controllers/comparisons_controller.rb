class ComparisonsController < ApplicationController
  #before_action :set_comparison, only: [:show, :edit, :update, :destroy]
  before_action :set_comparison_params
  layout "comparison"

  # GET /comparisons
  # GET /comparisons.json
  def index
    puts "comparison index"
    @partidos = Partido.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comparison_params
      @partido_ids = params[:partido_ids].nil? ? Partido.ids : params[:partido_ids]
      @category = params[:category].nil? ? 'category_1' : params[:category]
      puts "Comparing partidos with id: " + @partido_ids.join(',')
      puts "Category: " + @category
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comparison_params
      params.fetch(:comparison, {})
    end
end
