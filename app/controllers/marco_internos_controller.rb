class MarcoInternosController < ApplicationController
  before_action :set_marco_interno, only: [:show, :edit, :update, :destroy]

  # GET /marco_internos
  # GET /marco_internos.json
  def index
    @marco_internos = MarcoInterno.all
  end

  # GET /marco_internos/1
  # GET /marco_internos/1.json
  def show
  end

  # GET /marco_internos/new
  def new
    @marco_interno = MarcoInterno.new
    @marco_interno.documentos.build
  end

  # GET /marco_internos/1/edit
  def edit
  end

  # POST /marco_internos
  # POST /marco_internos.json
  def create
    @marco_interno = MarcoInterno.new(marco_interno_params)

    respond_to do |format|
      if @marco_interno.save
        format.html { redirect_to @marco_interno, notice: 'Marco interno was successfully created.' }
        format.json { render :show, status: :created, location: @marco_interno }
      else
        format.html { render :new }
        format.json { render json: @marco_interno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marco_internos/1
  # PATCH/PUT /marco_internos/1.json
  def update
    respond_to do |format|
      puts marco_interno_params.to_yaml
      
      if @marco_interno.update(marco_interno_params)
        format.html { redirect_to @marco_interno, notice: 'Marco interno was successfully updated.' }
        format.json { render :show, status: :ok, location: @marco_interno }
      else
        format.html { render :edit }
        format.json { render json: @marco_interno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marco_internos/1
  # DELETE /marco_internos/1.json
  def destroy
    @marco_interno.destroy
    respond_to do |format|
      format.html { redirect_to marco_internos_url, notice: 'Marco interno was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marco_interno
      @marco_interno = MarcoInterno.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marco_interno_params
      params.require(:marco_interno).permit(:id, :partido_id, documentos_attributes: [:id, :descripcion, :archivo, :_destroy])
    end
end
