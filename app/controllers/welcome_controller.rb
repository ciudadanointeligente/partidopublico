class WelcomeController < ApplicationController
    def index
       @partidos = Partido.all
    end


end
