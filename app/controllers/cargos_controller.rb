class CargosController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :update, :destroy]
  before_action :set_cargo, only: [:show, :edit, :update, :destroy]
  before_action :set_partido, only: [:index]

  # GET /cargos
  # GET /cargos.json
  def index
    @cargos = Cargo.where partido: @partido
  end

  # GET /cargos/1
  # GET /cargos/1.json
  def show
  end

  # GET /cargos/new
  def new
    @cargo = Cargo.new
  end

  # GET /cargos/1/edit
  def edit
  end

  # POST /cargos
  # POST /cargos.json
  def create
    PaperTrail.whodunnit = current_admin.email
    @cargo = Cargo.new(cargo_params)

    respond_to do |format|
      if @cargo.save
        format.html { redirect_to @cargo, notice: 'Cargo was successfully created.' }
        format.json { render :show, status: :created, location: @cargo }
      else
        format.html { render :new }
        format.json { render json: @cargo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cargos/1
  # PATCH/PUT /cargos/1.json
  def update
    PaperTrail.whodunnit = current_admin.email
    respond_to do |format|
      if @cargo.update(cargo_params)
        format.html { redirect_to @cargo, notice: 'Cargo was successfully updated.' }
        format.json { render :show, status: :ok, location: @cargo }
      else
        format.html { render :edit }
        format.json { render json: @cargo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cargos/1
  # DELETE /cargos/1.json
  def destroy
    PaperTrail.whodunnit = current_admin.email
    @cargo.destroy
    respond_to do |format|
      format.html { redirect_to cargos_url, notice: 'Cargo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cargo
      @cargo = Cargo.find(params[:id])
    end


    def set_partido
      @partido = Partido.find(params[:partido_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def cargo_params
      params.require(:cargo).permit(:id, :persona_id, :tipo_cargo_id, :partido_id, :fecha_desde, :fecha_hasta, :comuna_id, :region_id, :circunscripcion_id, :distrito_id, :organo_interno_id)
    end
end
