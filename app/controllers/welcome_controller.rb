class WelcomeController < ApplicationController
    def index
       @partidos = Partido.all

       render layout: "welcome"
    end
    def que_es
      @partidos = Partido.all
       render layout: "welcome"
    end


end
