class WelcomeController < ApplicationController
    def index
       @partidos = Partido.all
       render layout: 'nueva-ley-de-partidos-politicos'
    end


end
