class PersonasController < ApplicationController
  before_action :set_persona, only: [:show, :edit, :update, :destroy]
  before_action :set_partido, only: [:index, :create]
  # GET /personas
  # GET /personas.json
  # def index
  #   @personas = Persona.all
  # end

  # def index
  #   @grid = PersonasGrid.new(params[:personas_grid]) do |scope|
  #     scope.page(params[:page])
  #   end
  # end

  def index
    @personas = Persona.where partido: @partido
  end

  def foto_upload
    if remotipart_submitted?
      p "remotipart_submitted! remotipart_submitted! remotipart_submitted! remotipart_submitted! remotipart_submitted! "
    end
    respond_to do |format|

      if @persona.update(persona_params)
        format.js
      end
    end

    puts params.to_yaml
    file = params[:file]
  end

  # GET /personas/1
  # GET /personas/1.json
  def show
  end

  # GET /personas/new
  def new
    @persona = Persona.new
  end

  # GET /personas/1/edit
  def edit
  end

  # POST /personas
  # POST /personas.json
  def create
    @persona = Persona.new(persona_params)
    @persona.partido = @partido

    respond_to do |format|
      if @persona.save
        format.html { redirect_to @persona, notice: 'Persona was successfully created.' }
        format.json { render :show, status: :created, location: @persona }
      else
        format.html { render :new }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personas/1
  # PATCH/PUT /personas/1.json
  def update
    if remotipart_submitted?
      p "remotipart_submitted! remotipart_submitted! remotipart_submitted! remotipart_submitted! remotipart_submitted! "
    end
    respond_to do |format|
      if @persona.update(persona_params)
        format.html { redirect_to @persona, notice: 'Persona was successfully updated.' }
        format.json { render :show, status: :ok, location: @persona }
      else
        format.html { render :edit }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personas/1
  # DELETE /personas/1.json
  def destroy
    @persona.destroy
    respond_to do |format|
      format.html { redirect_to personas_url, notice: 'Persona was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import_personas

    Persona.import(params[:file], params[:partido_id])
    #return
    #render :text => params[:partido_id]
    redirect_to partido_steps_path(params[:partido_id], :personas)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_persona
      @persona = Persona.find(params[:id])
    end

    def set_partido
      @partido = Partido.find(params[:partido_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def persona_params
      params.require(:persona).permit(:id, :partido_id, :nombre, :apellidos, :genero, :fecha_nacimiento, :nivel_estudios, :region, :ano_inicio_militancia, :afiliado, :bio, :telefono, :email, :intereses, :patrimonio, :rut, :foto)
    end
end
