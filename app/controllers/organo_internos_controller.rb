class OrganoInternosController < ApplicationController
  before_action :set_organo_interno, only: [:show, :edit, :update, :destroy]

  # GET /organo_internos
  # GET /organo_internos.json
  def index
    @organo_internos = OrganoInterno.all
  end

  # GET /organo_internos/1
  # GET /organo_internos/1.json
  def show
  end

  # GET /organo_internos/new
  def new
    @organo_interno = OrganoInterno.new
    @organo_interno.personas.build
  end

  # GET /organo_internos/1/edit
  def edit
    @organo_interno.personas.build
  end

  # POST /organo_internos
  # POST /organo_internos.json
  def create
    @organo_interno = OrganoInterno.new(organo_interno_params)

    respond_to do |format|
      if @organo_interno.save
        format.html { redirect_to @organo_interno, notice: 'Organo interno was successfully created.' }
        format.json { render :show, status: :created, location: @organo_interno }
      else
        format.html { render :new }
        format.json { render json: @organo_interno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organo_internos/1
  # PATCH/PUT /organo_internos/1.json
  def update
    respond_to do |format|
      if @organo_interno.update(organo_interno_params)
        format.html { redirect_to @organo_interno, notice: 'Organo interno was successfully updated.' }
        format.json { render :show, status: :ok, location: @organo_interno }
      else
        format.html { render :edit }
        format.json { render json: @organo_interno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organo_internos/1
  # DELETE /organo_internos/1.json
  def destroy
    @organo_interno.destroy
    respond_to do |format|
      format.html { redirect_to organo_internos_url, notice: 'Organo interno was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organo_interno
      @organo_interno = OrganoInterno.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organo_interno_params
      params.require(:organo_interno).permit(:nombre, :funciones, personas_attributes: [:id, 
                                                                                        :fecha_nacimiento,
                                                                                        :nivel_estudios,
                                                                                        :nombre,
                                                                                        :region,
                                                                                        :ano_inicio_militancia,
                                                                                        :afiliado,
                                                                                        :bio,
                                                                                        :foto,
                                                                                        :apellidos,
                                                                                        :partido_id,
                                                                                        :personable_id,
                                                                                        :personable_type]
                                                                                        )
    end
end

