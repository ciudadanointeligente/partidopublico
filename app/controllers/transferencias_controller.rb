class TransferenciasController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_partido, only: [:aggregate_transferencias, :eliminar]
  before_action :set_transferencia, only: [:show, :edit, :update, :destroy]

  # GET /transferencias
  # GET /transferencias.json
  def index
    @transferencias = Transferencia.all
  end

  def aggregate_transferencias
    datos_by_partido = Transferencia.where partido: @partido
    fechas_distintas = datos_by_partido.uniq.pluck(:fecha_datos)
    @datos = []
    fechas_distintas.each do |fecha|
      datos_by_date = datos_by_partido.where("fecha_datos=to_date('" + fecha.to_s + "','YYYY-MM-DD')")
      count = datos_by_date.count
      total = datos_by_date.sum(:monto)
      line={:fecha_datos => fecha.strftime("%Y - %m"), :count => count, :total => total}
      @datos << line
    end
  end

  # GET /transferencias/1
  # GET /transferencias/1.json
  def show
  end

  # GET /transferencias/new
  def new
    @transferencia = Transferencia.new
  end

  # GET /transferencias/1/edit
  def edit
  end

  # POST /transferencias
  # POST /transferencias.json
  def create
    @transferencia = Transferencia.new(transferencia_params)

    respond_to do |format|
      if @transferencia.save
        format.html { redirect_to @transferencia, notice: 'Transferencia was successfully created.' }
        format.json { render :show, status: :created, location: @transferencia }
      else
        format.html { render :new }
        format.json { render json: @transferencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transferencias/1
  # PATCH/PUT /transferencias/1.json
  def update
    respond_to do |format|
      if @transferencia.update(transferencia_params)
        format.html { redirect_to @transferencia, notice: 'Transferencia was successfully updated.' }
        format.json { render :show, status: :ok, location: @transferencia }
      else
        format.html { render :edit }
        format.json { render json: @transferencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transferencias/1
  # DELETE /transferencias/1.json
  def destroy
    @transferencia.destroy
    respond_to do |format|
      format.html { redirect_to transferencias_url, notice: 'Transferencia was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def eliminar
    array_fecha = params[:fecha_datos].split(' - ')
    datos_partido = Transferencia.where partido: @partido
    datos_de_fecha = datos_partido.where fecha_datos: Date.new(array_fecha[0].to_i, array_fecha[1].to_i, 01)
    datos_de_fecha.delete_all
    render plain: "OK"
  end

  def import_transferencias
    return_values = Transferencia.import(params[:file], params[:partido_id], current_admin.email)
    respond_to do |format|
      #format.any { render json: return_values, content_type: 'application/json' }
      format.any { render file: "partido_steps/import_response.js.erb", content_type: "application/js" , :locals => { :return_values => return_values }}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transferencia
      @transferencia = Transferencia.find(params[:id])
    end


    def set_partido
      @partido = Partido.find(params[:partido_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transferencia_params
      params.require(:transferencia).permit(:partido_id, :fecha_datos, :numero, :razon_social, :rut, :region_id, :descripcion, :monto, :categoria, :fecha)
    end
end
