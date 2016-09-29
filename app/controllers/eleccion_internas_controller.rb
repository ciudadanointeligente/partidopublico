class EleccionInternasController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :update, :destroy]
  before_action :set_eleccion_interna, only: [:show, :edit, :update, :destroy]

  # GET /eleccion_internas
  # GET /eleccion_internas.json
  def index
    @eleccion_internas = EleccionInterna.all
  end

  # GET /eleccion_internas/1
  # GET /eleccion_internas/1.json
  def show
  end

  # GET /eleccion_internas/new
  def new
    @eleccion_interna = EleccionInterna.new
  end

  # GET /eleccion_internas/1/edit
  def edit
  end

  # POST /eleccion_internas
  # POST /eleccion_internas.json
  def create
    @eleccion_interna = EleccionInterna.new(eleccion_interna_params)

    respond_to do |format|
      if @eleccion_interna.save
        format.html { redirect_to @eleccion_interna, notice: 'Eleccion interna was successfully created.' }
        format.json { render :show, status: :created, location: @eleccion_interna }
      else
        format.html { render :new }
        format.json { render json: @eleccion_interna.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eleccion_internas/1
  # PATCH/PUT /eleccion_internas/1.json
  def update
    respond_to do |format|
      if @eleccion_interna.update(eleccion_interna_params)
        format.html { redirect_to @eleccion_interna, notice: 'Eleccion interna was successfully updated.' }
        format.json { render :show, status: :ok, location: @eleccion_interna }
      else
        format.html { render :edit }
        format.json { render json: @eleccion_interna.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eleccion_internas/1
  # DELETE /eleccion_internas/1.json
  def destroy
    @eleccion_interna.destroy
    respond_to do |format|
      format.html { redirect_to eleccion_internas_url, notice: 'Eleccion interna was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eleccion_interna
      @eleccion_interna = EleccionInterna.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def eleccion_interna_params
      params.require(:eleccion_interna).permit(:organo_interno_id, :fecha_eleccion, :fecha_limite_inscripcion, :cargo,
                                                                                                                requisitos_attributes: [:descripcion, :id, :_destroy],
                                                                                                                procedimientos_attributes: [:descripcion, :id, :_destroy]
                                                                                                                              )
    end
end
