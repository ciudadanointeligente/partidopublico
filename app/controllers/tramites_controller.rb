class TramitesController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :update, :destroy]
  before_action :set_tramite, only: [:show, :edit, :update, :destroy]

  # GET /tramites
  # GET /tramites.json
  def index
    @tramites = Tramite.all
  end

  # GET /tramites/1
  # GET /tramites/1.json
  def show
  end

  # GET /tramites/new
  def new
    @tramite = Tramite.new
  end

  # GET /tramites/1/edit
  def edit
  end

  # POST /tramites
  # POST /tramites.json
  def create
    @tramite = Tramite.new(tramite_params)

    respond_to do |format|
      if @tramite.save
        format.html { redirect_to @tramite, notice: 'Tramite was successfully created.' }
        format.json { render :show, status: :created, location: @tramite }
      else
        format.html { render :new }
        format.json { render json: @tramite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tramites/1
  # PATCH/PUT /tramites/1.json
  def update
    respond_to do |format|
      if @tramite.update(tramite_params)
        format.html { redirect_to @tramite, notice: 'Tramite was successfully updated.' }
        format.json { render :show, status: :ok, location: @tramite }
      else
        format.html { render :edit }
        format.json { render json: @tramite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tramites/1
  # DELETE /tramites/1.json
  def destroy
    @tramite.destroy
    respond_to do |format|
      format.html { redirect_to tramites_url, notice: 'Tramite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tramite
      @tramite = Tramite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tramite_params
      params.require(:tramite).permit(:nombre, :descripcion, :persona_id, :documento,
                                                              requisitos_attributes: [:descripcion, :id, :_destroy],
                                                              procedimientos_attributes: [:descripcion, :id, :_destroy]
                                                                            )
    end
end
