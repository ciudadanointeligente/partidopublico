class PartidosController < ApplicationController
  before_action :set_partido, only: [:show, :edit, :update, :destroy]

  # GET /partidos
  # GET /partidos.json
  def index
    @partidos = Partido.all
  end

  # GET /partidos/1
  # GET /partidos/1.json
  def show
  end

  # GET /partidos/new
  def new
    @partido = Partido.new
  end

  # GET /partidos/1/edit
  def edit
  end

  # POST /partidos
  # POST /partidos.json
  def create
    @partido = Partido.new(partido_params)

    respond_to do |format|
      if @partido.save
        format.html { redirect_to @partido, notice: 'Partido was successfully created.' }
        format.json { render :show, status: :created, location: @partido }
      else
        format.html { render :new }
        format.json { render json: @partido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /partidos/1
  # PATCH/PUT /partidos/1.json
  def update
    respond_to do |format|
      if @partido.update(partido_params)
        format.html { redirect_to @partido, notice: 'Partido was successfully updated.' }
        format.json { render :show, status: :ok, location: @partido }
      else
        format.html { render :edit }
        format.json { render json: @partido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /partidos/1
  # DELETE /partidos/1.json
  def destroy
    @partido.destroy
    respond_to do |format|
      format.html { redirect_to partidos_url, notice: 'Partido was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partido
      @partido = Partido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def partido_params
      # params.fetch(:partido, {:nombre, :sigla, :lema})
      params.require(:partido).permit(:nombre, :sigla, :lema, :fecha_fundacion, :texto)
    end
end
