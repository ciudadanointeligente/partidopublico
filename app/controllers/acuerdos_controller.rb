class AcuerdosController < ApplicationController
  before_action :set_acuerdo, only: [:show, :edit, :update, :destroy]

  # GET /acuerdos
  # GET /acuerdos.json
  def index
    @acuerdos = Acuerdo.all
  end

  # GET /acuerdos/1
  # GET /acuerdos/1.json
  def show
  end

  # GET /acuerdos/new
  def new
    @acuerdo = Acuerdo.new
  end

  # GET /acuerdos/1/edit
  def edit
  end

  # POST /acuerdos
  # POST /acuerdos.json
  def create
    @acuerdo = Acuerdo.new(acuerdo_params)

    respond_to do |format|
      if @acuerdo.save
        format.html { redirect_to @acuerdo, notice: 'Acuerdo was successfully created.' }
        format.json { render :show, status: :created, location: @acuerdo }
      else
        format.html { render :new }
        format.json { render json: @acuerdo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acuerdos/1
  # PATCH/PUT /acuerdos/1.json
  def update
    respond_to do |format|
      if @acuerdo.update(acuerdo_params)
        format.html { redirect_to @acuerdo, notice: 'Acuerdo was successfully updated.' }
        format.json { render :show, status: :ok, location: @acuerdo }
      else
        format.html { render :edit }
        format.json { render json: @acuerdo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acuerdos/1
  # DELETE /acuerdos/1.json
  def destroy
    @acuerdo.destroy
    respond_to do |format|
      format.html { redirect_to acuerdos_url, notice: 'Acuerdo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acuerdo
      @acuerdo = Acuerdo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acuerdo_params
      params.require(:acuerdo).permit(:numero, :fecha, :tipo, :tema, :region, :organo_interno_id, :documento)
    end
end
