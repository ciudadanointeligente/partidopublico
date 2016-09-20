class LeysController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :update, :destroy]
  before_action :set_ley, only: [:show, :edit, :update, :destroy]

  # GET /leys
  # GET /leys.json
  def index
    @leys = Ley.all
  end

  # GET /leys/1
  # GET /leys/1.json
  def show
  end

  # GET /leys/new
  def new
    @ley = Ley.new
  end

  # GET /leys/1/edit
  def edit
  end

  # POST /leys
  # POST /leys.json
  def create
    @ley = Ley.new(ley_params)

    respond_to do |format|
      if @ley.save
        format.html { redirect_to @ley, notice: 'Ley was successfully created.' }
        format.json { render :show, status: :created, location: @ley }
      else
        format.html { render :new }
        format.json { render json: @ley.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leys/1
  # PATCH/PUT /leys/1.json
  def update
    respond_to do |format|
      if @ley.update(ley_params)
        format.html { redirect_to @ley, notice: 'Ley was successfully updated.' }
        format.json { render :show, status: :ok, location: @ley }
      else
        format.html { render :edit }
        format.json { render json: @ley.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leys/1
  # DELETE /leys/1.json
  def destroy
    @ley.destroy
    respond_to do |format|
      format.html { redirect_to leys_url, notice: 'Ley was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ley
      @ley = Ley.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ley_params
      params.require(:ley).permit(:numero, :nombre, :enlace, :tags, :resumen, :marco_general_id)
    end
end
