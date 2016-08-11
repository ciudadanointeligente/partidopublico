class WelcomeController < ApplicationController
    def index
       @partidos = Partido.all

       render layout: "frontend"
    end

    def logo
		render layout: "logo"
	end

end
