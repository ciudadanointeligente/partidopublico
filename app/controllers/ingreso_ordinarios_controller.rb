class IngresoOrdinariosController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_ingreso_ordinario, only: [:show, :edit, :update, :destroy]
  before_action :set_partido, only: [:aggregate_ingresos_ordinarios, :eliminar]
  # GET /ingreso_ordinarios
  # GET /ingreso_ordinarios.json
  def index
    @ingreso_ordinarios = IngresoOrdinario.all
  end

  def aggregate_ingresos_ordinarios
    datos_by_partido = IngresoOrdinario.where partido: @partido
    fechas_distintas = datos_by_partido.uniq.pluck(:fecha_datos)
    @datos = []
    fechas_distintas.each do |fecha|
      datos_by_date = datos_by_partido.where("fecha_datos=to_date('" + fecha.to_s + "','YYYY-MM-DD')")
      count = datos_by_date.count
      total = datos_by_date.sum(:importe)
      line={:fecha_datos => fecha.strftime("%Y - %m"), :count => count, :total => total}
      @datos << line
    end
  end

  # GET /ingreso_ordinarios/1
  # GET /ingreso_ordinarios/1.json
  def show
  end

  # GET /ingreso_ordinarios/new
  def new
    @ingreso_ordinario = IngresoOrdinario.new
  end

  # GET /ingreso_ordinarios/1/edit
  def edit
  end

  # POST /ingreso_ordinarios
  # POST /ingreso_ordinarios.json
  def create
    @ingreso_ordinario = IngresoOrdinario.new(ingreso_ordinario_params)

    respond_to do |format|
      if @ingreso_ordinario.save
        format.html { redirect_to @ingreso_ordinario, notice: 'Ingreso ordinario was successfully created.' }
        format.json { render :show, status: :created, location: @ingreso_ordinario }
      else
        format.html { render :new }
        format.json { render json: @ingreso_ordinario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingreso_ordinarios/1
  # PATCH/PUT /ingreso_ordinarios/1.json
  def update
    respond_to do |format|
      if @ingreso_ordinario.update(ingreso_ordinario_params)
        format.html { redirect_to @ingreso_ordinario, notice: 'Ingreso ordinario was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingreso_ordinario }
      else
        format.html { render :edit }
        format.json { render json: @ingreso_ordinario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingreso_ordinarios/1
  # DELETE /ingreso_ordinarios/1.json
  def destroy
    @ingreso_ordinario.destroy
    respond_to do |format|
      format.html { redirect_to ingreso_ordinarios_url, notice: 'Ingreso ordinario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def eliminar
    array_fecha = params[:fecha_datos].split(' - ')
    datos_partido = IngresoOrdinario.where partido: @partido
    datos_de_fecha = datos_partido.where fecha_datos: Date.new(array_fecha[0].to_i, array_fecha[1].to_i, 01)
    datos_de_fecha.delete_all
    render plain: "OK"
  end

  def import_ingresos_ordinarios
    return_values = IngresoOrdinario.import(params[:file], params[:partido_id], current_admin.email)
    respond_to do |format|
      #format.any { render json: return_values, content_type: 'application/json' }
      format.any { render file: "partido_steps/import_response.js.erb", content_type: "application/js" , :locals => { :return_values => return_values }}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingreso_ordinario
      @ingreso_ordinario = IngresoOrdinario.find(params[:id])
    end

    def set_partido
      @partido = Partido.find(params[:partido_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingreso_ordinario_params
      #params.fetch(:ingreso_ordinario, {})
      params.require(:ingreso_ordinario).permit(:fecha_datos, :concepto, :importe)
    end
end
