class WelcomeController < ApplicationController
    def index
       @partidos = Partido.all
    end

    def logo
		render layout: "logo"
	end

end
