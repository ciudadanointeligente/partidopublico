class WelcomeController < ApplicationController
    def index
       @partidos = Partido.all
       render layout: 'partidos-politicos'
    end


end
