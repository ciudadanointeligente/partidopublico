class BalanceAnualsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :update, :destroy]
  before_action :set_balance_anual, only: [:show, :edit, :update, :destroy]
  before_action :set_partido, only: [:aggregate_balance_anual, :eliminar]

  # GET /balance_anuals
  # GET /balance_anuals.json
  def index
    @balance_anuals = BalanceAnual.all
  end

  def aggregate_balance_anual
    datos_by_partido = BalanceAnual.where partido: @partido
    fechas_distintas = datos_by_partido.uniq.pluck(:fecha_datos)
    @datos = []
    fechas_distintas.each do |fecha|
      datos_by_date = datos_by_partido.where("fecha_datos=to_date('" + fecha.to_s + "','YYYY-MM-DD')")
      count = datos_by_date.count
      datos_activos = datos_by_date.where(tipo: "activo")
      datos_pasivos = datos_by_date.where(tipo: "pasivo")
      total_activo = datos_activos.sum(:importe)
      total_pasivo = datos_pasivos.sum(:importe)
      line={:fecha_datos => fecha.strftime("%Y - %m"), :count => count, :total_activo => total_activo, :total_pasivo => total_pasivo}
      @datos << line
    end
  end
  # GET /balance_anuals/1
  # GET /balance_anuals/1.json
  def show
  end

  # GET /balance_anuals/new
  def new
    @balance_anual = BalanceAnual.new
  end

  # GET /balance_anuals/1/edit
  def edit
  end

  # POST /balance_anuals
  # POST /balance_anuals.json
  def create
    @balance_anual = BalanceAnual.new(balance_anual_params)

    respond_to do |format|
      if @balance_anual.save
        format.html { redirect_to @balance_anual, notice: 'Balance anual was successfully created.' }
        format.json { render :show, status: :created, location: @balance_anual }
      else
        format.html { render :new }
        format.json { render json: @balance_anual.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /balance_anuals/1
  # PATCH/PUT /balance_anuals/1.json
  def update
    respond_to do |format|
      if @balance_anual.update(balance_anual_params)
        format.html { redirect_to @balance_anual, notice: 'Balance anual was successfully updated.' }
        format.json { render :show, status: :ok, location: @balance_anual }
      else
        format.html { render :edit }
        format.json { render json: @balance_anual.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /balance_anuals/1
  # DELETE /balance_anuals/1.json
  def destroy
    @balance_anual.destroy
    respond_to do |format|
      format.html { redirect_to balance_anuals_url, notice: 'Balance anual was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def eliminar
    array_fecha = params[:fecha_datos].split(' - ')
    datos_partido = BalanceAnual.where partido: @partido
    datos_de_fecha = datos_partido.where fecha_datos: Date.new(array_fecha[0].to_i, array_fecha[1].to_i, 01)
    datos_de_fecha.delete_all
    render plain: "OK"
  end

  def import_balance_anual
    return_values = BalanceAnual.import(params[:file], params[:partido_id], current_admin.email)
    respond_to do |format|
      #format.any { render json: return_values, content_type: 'application/json' }
      format.any { render file: "partido_steps/import_response.js.erb", content_type: "application/js" , :locals => { :return_values => return_values }}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_balance_anual
      @balance_anual = BalanceAnual.find(params[:id])
    end

    def set_partido
      @partido = Partido.find(params[:partido_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def balance_anual_params
      params.require(:balance_anual).permit(:partido_id, :fecha_datos, :concepto, :tipo, :importe)
    end
end
