class ItemContablesController < ApplicationController
  before_action :set_partido, only: [:index, :update, :create]
  before_action :set_item_contable, only: [:update, :destroy]
  respond_to :json

  def index
    @item_contables = @partido.item_contables
  end

  def show
    @item_contable = ItemContable.find(params[:id])
  end

  def update
    puts '---params---'
    p item_contable_params
    puts '---params---'

    respond_to do |format|
      if @item_contable.update(item_contable_params)
        format.json { render :show, status: :ok }
      else
        format.json { render json: @item_contable.errors, status: :unprocessable_entity }
      end
    end

  end

  def create
    @item_contable = ItemContable.new(item_contable_params)

    respond_to do |format|
      if @item_contable.save
        @partido.item_contables << @item_contable

        # format.html { redirect_to @item_contable, notice: 'item_contable was successfully created.' }
        format.json { render :show, status: :created }
      else
        # format.html { render :new }
        format.json { render json: @item_contable.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item_contable.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

    def set_partido
      @partido = Partido.find(params[:partido_id])
    end

    def set_item_contable
      @item_contable = ItemContable.find(params[:id])
    end

    def item_contable_params
      params.require(:item_contable).permit(:importe, :concepto, :categoria_financiera_id, :dinero_publico)
    end

end
