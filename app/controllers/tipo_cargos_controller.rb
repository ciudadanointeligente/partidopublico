class TipoCargosController < ApplicationController
  before_action :set_tipo_cargo, only: [:show, :edit, :update, :destroy]

  # GET /tipo_cargos
  # GET /tipo_cargos.json
  def index
    @tipo_cargos = TipoCargo.all
  end

  # GET /tipo_cargos/1
  # GET /tipo_cargos/1.json
  def show
  end

  # GET /tipo_cargos/new
  def new
    @tipo_cargo = TipoCargo.new
  end

  # GET /tipo_cargos/1/edit
  def edit
  end

  # POST /tipo_cargos
  # POST /tipo_cargos.json
  def create
    @tipo_cargo = TipoCargo.new(tipo_cargo_params)

    respond_to do |format|
      if @tipo_cargo.save
        format.html { redirect_to @tipo_cargo, notice: 'Tipo cargo was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_cargo }
      else
        format.html { render :new }
        format.json { render json: @tipo_cargo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_cargos/1
  # PATCH/PUT /tipo_cargos/1.json
  def update
    respond_to do |format|
      if @tipo_cargo.update(tipo_cargo_params)
        format.html { redirect_to @tipo_cargo, notice: 'Tipo cargo was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_cargo }
      else
        format.html { render :edit }
        format.json { render json: @tipo_cargo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_cargos/1
  # DELETE /tipo_cargos/1.json
  def destroy
    @tipo_cargo.destroy
    respond_to do |format|
      format.html { redirect_to tipo_cargos_url, notice: 'Tipo cargo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_cargo
      @tipo_cargo = TipoCargo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_cargo_params
      params.require(:tipo_cargo).permit(:titulo)
    end
end
