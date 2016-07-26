class AfiliacionsController < ApplicationController
  
  before_action :authenticate_admin!
  before_action :set_afiliacion, only: [:show, :edit, :update, :destroy]
  before_action :set_partido, only: [:index, :aggregate, :eliminar]

  # GET /afiliacions
  # GET /afiliacions.json
  def index
    @afiliacions = Afiliacion.where partido: @partido
  end

  def aggregate
    datos_by_partido = Afiliacion.where partido: @partido
    fechas_distintas = datos_by_partido.uniq.pluck(:fecha_datos)
    @datos = []
    fechas_distintas.each do |fecha|
      datos_by_date = datos_by_partido.where("fecha_datos=to_date('" + fecha.to_s + "','YYYY-MM-DD')")
      count_regiones = datos_by_date.count(:region_id).to_json
      total_afiliados = datos_by_date.sum(:hombres) + datos_by_date.sum(:mujeres) + datos_by_date.sum(:otros)
      line={:fecha_datos => fecha.strftime("%Y - %m"), :count_regiones => count_regiones, :total_afiliados => total_afiliados}
      @datos << line
    end
  end

  # GET /afiliacions/1
  # GET /afiliacions/1.json
  def show
  end

  # GET /afiliacions/new
  def new
    @afiliacion = Afiliacion.new
  end

  # GET /afiliacions/1/edit
  def edit
  end

  # POST /afiliacions
  # POST /afiliacions.json
  def create
    @afiliacion = Afiliacion.new(afiliacion_params)

    respond_to do |format|
      if @afiliacion.save
        format.html { redirect_to @afiliacion, notice: 'Afiliacion was successfully created.' }
        format.json { render :show, status: :created, location: @afiliacion }
      else
        format.html { render :new }
        format.json { render json: @afiliacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /afiliacions/1
  # PATCH/PUT /afiliacions/1.json
  def update
    respond_to do |format|
      if @afiliacion.update(afiliacion_params)
        format.html { redirect_to @afiliacion, notice: 'Afiliacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @afiliacion }
      else
        format.html { render :edit }
        format.json { render json: @afiliacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /afiliacions/1
  # DELETE /afiliacions/1.json
  def destroy
    @afiliacion.destroy
    respond_to do |format|
      format.html { redirect_to afiliacions_url, notice: 'Afiliacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def eliminar
    array_fecha = params[:fecha_datos].split(' - ')
    afiliaciones_partido = Afiliacion.where partido: @partido
    afiliaciones_por_fecha = afiliaciones_partido.where fecha_datos: Date.new(array_fecha[0].to_i, array_fecha[1].to_i, 01)
    afiliaciones_por_fecha.delete_all
    render plain: "OK"
  end

  def import_afiliacion
    return_values = Afiliacion.import(params[:file], params[:partido_id],PaperTrail.whodunnit = current_admin.email)
    respond_to do |format|
      #format.any { render json: return_values, content_type: 'application/json' }
      format.any { render file: "partido_steps/import_response.js.erb", content_type: "application/js" , :locals => { :return_values => return_values }}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_afiliacion
      @afiliacion = Afiliacion.find(params[:id])
    end

    def set_partido
      @partido = Partido.find(params[:partido_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def afiliacion_params
      params.require(:afiliacion).permit(:fecha_datos, :region_id, :hombres, :mujeres, :rangos)
    end
end
