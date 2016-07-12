class WelcomeController < ApplicationController
    def index
       @partidos = Partido.all
       render layout: 'transparencia'
    end


end
