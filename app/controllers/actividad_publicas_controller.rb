class ActividadPublicasController < ApplicationController
  before_action :set_actividad_publica, only: [:show, :edit, :update, :destroy]

  # GET /actividad_publicas
  # GET /actividad_publicas.json
  def index
    @actividad_publicas = ActividadPublica.all
  end

  # GET /actividad_publicas/1
  # GET /actividad_publicas/1.json
  def show
  end

  # GET /actividad_publicas/new
  def new
    @actividad_publica = ActividadPublica.new
  end

  # GET /actividad_publicas/1/edit
  def edit
  end

  # POST /actividad_publicas
  # POST /actividad_publicas.json
  def create
    @actividad_publica = ActividadPublica.new(actividad_publica_params)

    respond_to do |format|
      if @actividad_publica.save
        format.html { redirect_to @actividad_publica, notice: 'Actividad publica was successfully created.' }
        format.json { render :show, status: :created, location: @actividad_publica }
      else
        format.html { render :new }
        format.json { render json: @actividad_publica.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actividad_publicas/1
  # PATCH/PUT /actividad_publicas/1.json
  def update
    respond_to do |format|
      if @actividad_publica.update(actividad_publica_params)
        format.html { redirect_to @actividad_publica, notice: 'Actividad publica was successfully updated.' }
        format.json { render :show, status: :ok, location: @actividad_publica }
      else
        format.html { render :edit }
        format.json { render json: @actividad_publica.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actividad_publicas/1
  # DELETE /actividad_publicas/1.json
  def destroy
    @actividad_publica.destroy
    respond_to do |format|
      format.html { redirect_to actividad_publicas_url, notice: 'Actividad publica was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actividad_publica
      @actividad_publica = ActividadPublica.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def actividad_publica_params
      params.fetch(:actividad_publica, {})
    end
end
