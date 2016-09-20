class EleccionPopularsController < ApplicationController
  before_action :set_eleccion_popular, only: [:show, :edit, :update, :destroy]

  # GET /eleccion_populars
  # GET /eleccion_populars.json
  def index
    @eleccion_populars = EleccionPopular.all
  end

  # GET /eleccion_populars/1
  # GET /eleccion_populars/1.json
  def show
  end

  # GET /eleccion_populars/new
  def new
    @eleccion_popular = EleccionPopular.new
  end

  # GET /eleccion_populars/1/edit
  def edit
  end

  # POST /eleccion_populars
  # POST /eleccion_populars.json
  def create
    @eleccion_popular = EleccionPopular.new(eleccion_popular_params)

    respond_to do |format|
      if @eleccion_popular.save
        format.html { redirect_to @eleccion_popular, notice: 'Eleccion popular was successfully created.' }
        format.json { render :show, status: :created, location: @eleccion_popular }
      else
        format.html { render :new }
        format.json { render json: @eleccion_popular.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eleccion_populars/1
  # PATCH/PUT /eleccion_populars/1.json
  def update
    respond_to do |format|
      if @eleccion_popular.update(eleccion_popular_params)
        format.html { redirect_to @eleccion_popular, notice: 'Eleccion popular was successfully updated.' }
        format.json { render :show, status: :ok, location: @eleccion_popular }
      else
        format.html { render :edit }
        format.json { render json: @eleccion_popular.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eleccion_populars/1
  # DELETE /eleccion_populars/1.json
  def destroy
    @eleccion_popular.destroy
    respond_to do |format|
      format.html { redirect_to eleccion_populars_url, notice: 'Eleccion popular was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eleccion_popular
      @eleccion_popular = EleccionPopular.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def eleccion_popular_params
      params.require(:eleccion_popular).permit(:fecha_eleccion, :dias, :cargo,
                                                                                                                requisitos_attributes: [:descripcion, :id, :_destroy],
                                                                                                                procedimientos_attributes: [:descripcion, :id, :_destroy]
                                                                                                                              )
    end
end
