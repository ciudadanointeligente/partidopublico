class StaticController < ApplicationController
  def show
    render params[:page], layout: nil
  end
end
