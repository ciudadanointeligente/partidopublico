class EgresoOrdinariosController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :update, :destroy, :aggregate_egresos_ordinarios, :eliminar, :import_egresos_ordinarios]
  before_action :set_egreso_ordinario, only: [:show, :edit, :update, :destroy]
  before_action :set_partido, only: [:aggregate_egresos_ordinarios, :eliminar]

  # GET /egreso_ordinarios
  # GET /egreso_ordinarios.json
  def index
    @egreso_ordinarios = EgresoOrdinario.all
  end

  def aggregate_egresos_ordinarios
    @datos_eficientes = EgresoOrdinario.where(:partido => @partido).group("date(fecha_datos)").
    select("fecha_datos, count(1) as count, sum(privado) as total_privado, sum(publico) as total_publico").order(:fecha_datos)

    @datos_eficientes.each do |d|
      d.attributes.symbolize_keys!
    end
  end

  # GET /egreso_ordinarios/1
  # GET /egreso_ordinarios/1.json
  def show
  end

  # GET /egreso_ordinarios/new
  def new
    @egreso_ordinario = EgresoOrdinario.new
  end

  # GET /egreso_ordinarios/1/edit
  def edit
  end

  # POST /egreso_ordinarios
  # POST /egreso_ordinarios.json
  def create
    @egreso_ordinario = EgresoOrdinario.new(egreso_ordinario_params)

    respond_to do |format|
      if @egreso_ordinario.save
        format.html { redirect_to @egreso_ordinario, notice: 'Egreso ordinario was successfully created.' }
        format.json { render :show, status: :created, location: @egreso_ordinario }
      else
        format.html { render :new }
        format.json { render json: @egreso_ordinario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /egreso_ordinarios/1
  # PATCH/PUT /egreso_ordinarios/1.json
  def update
    respond_to do |format|
      if @egreso_ordinario.update(egreso_ordinario_params)
        format.html { redirect_to @egreso_ordinario, notice: 'Egreso ordinario was successfully updated.' }
        format.json { render :show, status: :ok, location: @egreso_ordinario }
      else
        format.html { render :edit }
        format.json { render json: @egreso_ordinario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /egreso_ordinarios/1
  # DELETE /egreso_ordinarios/1.json
  def destroy
    @egreso_ordinario.destroy
    respond_to do |format|
      format.html { redirect_to egreso_ordinarios_url, notice: 'Egreso ordinario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def eliminar
    #array_fecha = params[:fecha_datos].split(' - ')
    fecha_eliminacion = Date.new(params[:fecha_datos].split("-")[0].to_i, params[:fecha_datos].split("-")[1].to_i, params[:fecha_datos].split("-")[2].to_i)
    datos_partido = EgresoOrdinario.where partido: @partido
    #datos_de_fecha = datos_partido.where fecha_datos: Date.new(array_fecha[0].to_i, array_fecha[1].to_i, 01)
    datos_de_fecha = datos_partido.where fecha_datos: fecha_eliminacion
    datos_de_fecha.delete_all
    render plain: "OK"
  end

  def import_egresos_ordinarios
    return_values = EgresoOrdinario.import(params[:file], params[:partido_id], current_admin.email)
    respond_to do |format|
      #format.any { render json: return_values, content_type: 'application/json' }
      format.any { render file: "partido_steps/import_response.js.erb", content_type: "application/js" , :locals => { :return_values => return_values }}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_egreso_ordinario
      @egreso_ordinario = EgresoOrdinario.find(params[:id])
    end

    def set_partido
      @partido = Partido.find(params[:partido_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def egreso_ordinario_params
      params.require(:egreso_ordinario).permit(:partido_id, :fecha_datos, :concepto, :privado, :publico)
    end
end
