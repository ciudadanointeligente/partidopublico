class WelcomeController < ApplicationController
    def index
       @partidos = Partido.all
       render layout: 'entra-a-la-cancha'
    end


end
