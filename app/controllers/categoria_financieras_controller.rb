class CategoriaFinancierasController < ApplicationController
  before_action :set_partido, only: [:index]
  respond_to :json

  def index
    @categorias_financieras = @partido.categoria_financieras
  end

  private

  def set_partido
    @partido = Partido.find(params[:partido_id])
  end
end
