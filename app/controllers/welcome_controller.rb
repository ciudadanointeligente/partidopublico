class WelcomeController < ApplicationController
    def index
       @partidos = Partido.all

       #render layout: "frontend"
    end


end
