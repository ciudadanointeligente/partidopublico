class ProcedimientosController < ApplicationController
  before_action :set_procedimiento, only: [:show, :edit, :update, :destroy]

  # GET /procedimientos
  # GET /procedimientos.json
  def index
    @procedimientos = Procedimiento.all
  end

  # GET /procedimientos/1
  # GET /procedimientos/1.json
  def show
  end

  # GET /procedimientos/new
  def new
    @procedimiento = Procedimiento.new
  end

  # GET /procedimientos/1/edit
  def edit
  end

  # POST /procedimientos
  # POST /procedimientos.json
  def create
    @procedimiento = Procedimiento.new(procedimiento_params)

    respond_to do |format|
      if @procedimiento.save
        format.html { redirect_to @procedimiento, notice: 'Procedimiento was successfully created.' }
        format.json { render :show, status: :created, location: @procedimiento }
      else
        format.html { render :new }
        format.json { render json: @procedimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /procedimientos/1
  # PATCH/PUT /procedimientos/1.json
  def update
    respond_to do |format|
      if @procedimiento.update(procedimiento_params)
        format.html { redirect_to @procedimiento, notice: 'Procedimiento was successfully updated.' }
        format.json { render :show, status: :ok, location: @procedimiento }
      else
        format.html { render :edit }
        format.json { render json: @procedimiento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /procedimientos/1
  # DELETE /procedimientos/1.json
  def destroy
    @procedimiento.destroy
    respond_to do |format|
      format.html { redirect_to procedimientos_url, notice: 'Procedimiento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_procedimiento
      @procedimiento = Procedimiento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def procedimiento_params
      params.require(:procedimiento).permit(:descripcion)
    end
end
