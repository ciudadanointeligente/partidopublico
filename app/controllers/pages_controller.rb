class PagesController < ApplicationController
  def twittea
    @partidos = Partido.all
    render layout: "welcome"
  end
end
