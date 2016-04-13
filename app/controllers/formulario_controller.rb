class FormularioController < ApplicationController
  
  respond_to :html, :json, :js
  
  def update_comunas
    provincias = Provincia.where "region_id = ?", params[:region_id]
    @element_id = params[:element_id]
    @comunas = []
    provincias.each do |p|
      @comunas.append p.comunas
    end
    
    respond_to do |format|
      format.js
    end
  end
end
