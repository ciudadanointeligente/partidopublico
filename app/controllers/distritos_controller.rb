class DistritosController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :update, :destroy]
  before_action :set_distrito, only: [:show, :edit, :update, :destroy]

  # GET /distritos
  # GET /distritos.json
  def index
    @distritos = Distrito.all
  end

  # GET /distritos/1
  # GET /distritos/1.json
  def show
  end

  # GET /distritos/new
  def new
    @distrito = Distrito.new
  end

  # GET /distritos/1/edit
  def edit
  end

  # POST /distritos
  # POST /distritos.json
  def create
    @distrito = Distrito.new(distrito_params)

    respond_to do |format|
      if @distrito.save
        format.html { redirect_to @distrito, notice: 'Distrito was successfully created.' }
        format.json { render :show, status: :created, location: @distrito }
      else
        format.html { render :new }
        format.json { render json: @distrito.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /distritos/1
  # PATCH/PUT /distritos/1.json
  def update
    respond_to do |format|
      if @distrito.update(distrito_params)
        format.html { redirect_to @distrito, notice: 'Distrito was successfully updated.' }
        format.json { render :show, status: :ok, location: @distrito }
      else
        format.html { render :edit }
        format.json { render json: @distrito.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /distritos/1
  # DELETE /distritos/1.json
  def destroy
    @distrito.destroy
    respond_to do |format|
      format.html { redirect_to distritos_url, notice: 'Distrito was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_distrito
      @distrito = Distrito.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def distrito_params
      params.fetch(:distrito, {})
    end
end
