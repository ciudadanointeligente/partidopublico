class WelcomeController < ApplicationController
    def index
       @partidos = Partido.all
       render layout: 'lanzamiento'
    end


end
