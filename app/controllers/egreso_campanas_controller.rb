class EgresoCampanasController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :update, :destroy, :aggregate_egresos_campanas, :eliminar, :import_egresos_campanas]
  before_action :set_partido, only: [:aggregate_egresos_campanas, :eliminar]
  before_action :set_egreso_campana, only: [:show, :edit, :update, :destroy]

  # GET /egreso_campanas
  # GET /egreso_campanas.json
  def index
    @egreso_campanas = EgresoCampana.all
  end

  def aggregate_egresos_campanas
    datos_by_partido = EgresoCampana.where partido: @partido
    fechas_distintas = datos_by_partido.uniq.pluck(:fecha_datos)
    @datos = []
    fechas_distintas.each do |fecha|
      datos_by_date = datos_by_partido.where("fecha_datos=to_date('" + fecha.to_s + "','YYYY-MM-DD')")
      fecha_eleccion = datos_by_date.uniq.pluck(:fecha_eleccion).first
      count = datos_by_date.count
      total = datos_by_date.sum(:monto)
      line={:fecha_datos => fecha.strftime("%Y - %m"), :fecha_eleccion => fecha_eleccion,  :count => count, :total => total}
      @datos << line
    end
  end

  # GET /egreso_campanas/1
  # GET /egreso_campanas/1.json
  def show
  end

  # GET /egreso_campanas/new
  def new
    @egreso_campana = EgresoCampana.new
  end

  # GET /egreso_campanas/1/edit
  def edit
  end

  # POST /egreso_campanas
  # POST /egreso_campanas.json
  def create
    @egreso_campana = EgresoCampana.new(egreso_campana_params)

    respond_to do |format|
      if @egreso_campana.save
        format.html { redirect_to @egreso_campana, notice: 'Egreso campana was successfully created.' }
        format.json { render :show, status: :created, location: @egreso_campana }
      else
        format.html { render :new }
        format.json { render json: @egreso_campana.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /egreso_campanas/1
  # PATCH/PUT /egreso_campanas/1.json
  def update
    respond_to do |format|
      if @egreso_campana.update(egreso_campana_params)
        format.html { redirect_to @egreso_campana, notice: 'Egreso campana was successfully updated.' }
        format.json { render :show, status: :ok, location: @egreso_campana }
      else
        format.html { render :edit }
        format.json { render json: @egreso_campana.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /egreso_campanas/1
  # DELETE /egreso_campanas/1.json
  def destroy
    @egreso_campana.destroy
    respond_to do |format|
      format.html { redirect_to egreso_campanas_url, notice: 'Egreso campana was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def eliminar
    array_fecha = params[:fecha_datos].split(' - ')
    datos_partido = EgresoCampana.where partido: @partido
    datos_de_fecha = datos_partido.where fecha_datos: Date.new(array_fecha[0].to_i, array_fecha[1].to_i, 01)
    datos_de_fecha.delete_all
    render plain: "OK"
  end

  def import_egresos_campanas
    return_values = EgresoCampana.import(params[:file], params[:partido_id], current_admin.email)
    respond_to do |format|
      #format.any { render json: return_values, content_type: 'application/json' }
      format.any { render file: "partido_steps/import_response.js.erb", content_type: "application/js" , :locals => { :return_values => return_values }}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_egreso_campana
      @egreso_campana = EgresoCampana.find(params[:id])
    end

    def set_partido
      @partido = Partido.find(params[:partido_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def egreso_campana_params
      params.require(:egreso_campana).permit(:partido_id, :fecha_datos, :fecha_eleccion, :rut_candidato, :rut_proveedor, :nombre, :proveedor, :fecha_documento, :tipo_documento, :numero_documento, :numero_cuenta, :p_o_c, :glosa, :monto)
    end
end
