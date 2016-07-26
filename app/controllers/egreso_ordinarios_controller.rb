class EgresoOrdinariosController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_egreso_ordinario, only: [:show, :edit, :update, :destroy]
  before_action :set_partido, only: [:aggregate_egresos_ordinarios, :eliminar]

  # GET /egreso_ordinarios
  # GET /egreso_ordinarios.json
  def index
    @egreso_ordinarios = EgresoOrdinario.all
  end

  def aggregate_egresos_ordinarios
    datos_by_partido = EgresoOrdinario.where partido: @partido
    fechas_distintas = datos_by_partido.uniq.pluck(:fecha_datos)
    @datos = []
    fechas_distintas.each do |fecha|
      datos_by_date = datos_by_partido.where("fecha_datos=to_date('" + fecha.to_s + "','YYYY-MM-DD')")
      count = datos_by_date.count
      total_privado = datos_by_date.sum(:privado)
      total_publico = datos_by_date.sum(:publico)
      line={:fecha_datos => fecha.strftime("%Y - %m"), :count => count, :total_privado => total_privado, :total_publico => total_publico}
      @datos << line
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
    array_fecha = params[:fecha_datos].split(' - ')
    datos_partido = EgresoOrdinario.where partido: @partido
    datos_de_fecha = datos_partido.where fecha_datos: Date.new(array_fecha[0].to_i, array_fecha[1].to_i, 01)
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
