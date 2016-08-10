class ContratacionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_contratacion, only: [:show, :edit, :update, :destroy]
  before_action :set_partido, only: [:aggregate_contrataciones, :eliminar]

  # GET /contratacions
  # GET /contratacions.json
  def index
    @contratacions = Contratacion.all
  end

  def aggregate_contrataciones
    datos_by_partido = Contratacion.where partido: @partido
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

  # GET /contratacions/1
  # GET /contratacions/1.json
  def show
  end

  # GET /contratacions/new
  def new
    @contratacion = Contratacion.new
  end

  # GET /contratacions/1/edit
  def edit
  end

  # POST /contratacions
  # POST /contratacions.json
  def create
    @contratacion = Contratacion.new(contratacion_params)

    respond_to do |format|
      if @contratacion.save
        format.html { redirect_to @contratacion, notice: 'Contratacion was successfully created.' }
        format.json { render :show, status: :created, location: @contratacion }
      else
        format.html { render :new }
        format.json { render json: @contratacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contratacions/1
  # PATCH/PUT /contratacions/1.json
  def update
    respond_to do |format|
      if @contratacion.update(contratacion_params)
        format.html { redirect_to @contratacion, notice: 'Contratacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @contratacion }
      else
        format.html { render :edit }
        format.json { render json: @contratacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contratacions/1
  # DELETE /contratacions/1.json
  def destroy
    @contratacion.destroy
    respond_to do |format|
      format.html { redirect_to contratacions_url, notice: 'Contratacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def eliminar
    array_fecha = params[:fecha_datos].split(' - ')
    datos_partido = Contratacion.where partido: @partido
    datos_de_fecha = datos_partido.where fecha_datos: Date.new(array_fecha[0].to_i, array_fecha[1].to_i, 01)
    datos_de_fecha.delete_all
    render plain: "OK"
  end

  def import_contrataciones
    return_values = Contratacion.import(params[:file], params[:partido_id], current_admin.email)
    respond_to do |format|
      #format.any { render json: return_values, content_type: 'application/json' }
      format.any { render file: "partido_steps/import_response.js.erb", content_type: "application/js" , :locals => { :return_values => return_values }}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contratacion
      @contratacion = Contratacion.find(params[:id])
    end


    def set_partido
      @partido = Partido.find(params[:partido_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contratacion_params
      params.require(:contratacion).permit(:partido_id, :fecha_datos, :numero, :individualizacion, :razon_social, :rut, :titulares, :descripcion, :monto, :fecha_inicio, :fecha_termino, :link)
    end
end
