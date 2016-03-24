class PartidoStepsController < ApplicationController
    include Wicked::Wizard

    steps :datos_basicos, :marco_interno, :postulacion_popular, :postulacion_interna, :acuerdos, :afiliacion, :sedes
    
    def show
        @user = current_user
        @partido = Partido.find_by_user_id(current_user.id)
        render_wizard
    end
  
end
