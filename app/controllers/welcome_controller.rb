class WelcomeController < ApplicationController
    def index
       @partidos = Partido.all

       render layout: "welcome"
    end


end
