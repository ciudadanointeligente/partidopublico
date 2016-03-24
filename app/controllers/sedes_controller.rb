class SedesController < ApplicationController
  before_action :set_sede, only: [:show, :edit, :update, :destroy]

  # GET /sedes
  # GET /sedes.json
  def index
    @sedes = Sede.all
  end

  # GET /sedes/1
  # GET /sedes/1.json
  def show
  end

  # GET /sedes/new
  def new
    @sede = Sede.new
  end

  # GET /sedes/1/edit
  def edit
  end

  # POST /sedes
  # POST /sedes.json
  def create
    @sede = Sede.new(sede_params)

    respond_to do |format|
      if @sede.save
        format.html { redirect_to @sede, notice: 'Sede was successfully created.' }
        format.json { render :show, status: :created, location: @sede }
      else
        format.html { render :new }
        format.json { render json: @sede.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sedes/1
  # PATCH/PUT /sedes/1.json
  def update
    respond_to do |format|
      if @sede.update(sede_params)
        format.html { redirect_to @sede, notice: 'Sede was successfully updated.' }
        format.json { render :show, status: :ok, location: @sede }
      else
        format.html { render :edit }
        format.json { render json: @sede.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sedes/1
  # DELETE /sedes/1.json
  def destroy
    @sede.destroy
    respond_to do |format|
      format.html { redirect_to sedes_url, notice: 'Sede was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sede
      @sede = Sede.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sede_params
      params.require(:sede).permit(:region, :direccion, :contacto)
    end
end
