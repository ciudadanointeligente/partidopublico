class FormularioController < ApplicationController
  before_action :authenticate_admin!, only: [:update_comunas, :update_distritos]
  respond_to :html, :json, :js

  def update_comunas
    provincias = Provincia.where "region_id = ?", params[:region_id]
    @element_id = params[:element_id]
    @comunas = []
    provincias.each do |p|
      @comunas =@comunas + p.comunas
    end
    respond_to do |format|
      format.js
    end
  end

  def update_distritos
    @distritos = Distrito.where "circunscripcion_id = ?", params[:circunscripcion_id]
    @element_id = params[:element_id]
    respond_to do |format|
      format.js
    end
  end

end
