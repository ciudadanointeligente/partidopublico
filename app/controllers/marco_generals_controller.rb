class MarcoGeneralsController < ApplicationController
  before_action :set_marco_general, only: [:show, :edit, :update, :destroy]

  # GET /marco_generals
  # GET /marco_generals.json
  def index
    @marco_generals = MarcoGeneral.all
  end

  # GET /marco_generals/1
  # GET /marco_generals/1.json
  def show
  end

  # GET /marco_generals/new
  def new
    @marco_general = MarcoGeneral.new
    
  end

  # GET /marco_generals/1/edit
  def edit
  end

  # POST /marco_generals
  # POST /marco_generals.json
  def create
    @marco_general = MarcoGeneral.new(marco_general_params)

    respond_to do |format|
      if @marco_general.save
        format.html { redirect_to @marco_general, notice: 'Marco general was successfully created.' }
        format.json { render :show, status: :created, location: @marco_general }
      else
        format.html { render :new }
        format.json { render json: @marco_general.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marco_generals/1
  # PATCH/PUT /marco_generals/1.json
  def update
    respond_to do |format|
      if @marco_general.update(marco_general_params)
        format.html { redirect_to @marco_general, notice: 'Marco general was successfully updated.' }
        format.json { render :show, status: :ok, location: @marco_general }
      else
        format.html { render :edit }
        format.json { render json: @marco_general.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marco_generals/1
  # DELETE /marco_generals/1.json
  def destroy
    @marco_general.destroy
    respond_to do |format|
      format.html { redirect_to marco_generals_url, notice: 'Marco general was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marco_general
      @marco_general = MarcoGeneral.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marco_general_params
      params.require(:marco_general).permit(:partido_id, leys_attributes: [:numero, :nombre, :enlace])
    end
end
