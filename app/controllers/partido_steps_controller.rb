class PartidoStepsController < ApplicationController
    include Wicked::Wizard
    helper  :all
    
    before_action :set_partido
        
    steps :datos_basicos, :marco_interno, :postulacion_popular, :postulacion_interna, :acuerdos, :afiliacion, :sedes
    
    def show
        @user = current_user
        @partido = Partido.find_by_user_id(current_user.id)
        render_wizard
    end
    
    def update
        # puts params[:partido]
        @partido = Partido.find_by_user_id(current_user.id)
        @partido.update_attributes(partido_params)
        render_wizard @partido
    end
  
    private
        # Use callbacks to share common setup or constraints between actions.
        def set_partido
          @partido = Partido.find_by_user_id(current_user.id)
        end
    
        # Never trust parameters from the scary internet, only allow the white list through.
        def partido_params
          # params.fetch(:partido, {:nombre, :sigla, :lema})
          params.require(:partido).permit(:nombre, :sigla, :lema, :fecha_fundacion, :texto, :logo,
          marco_internos_attributes: [:partido_id, documentos_attributes: [:id, :descripcion, :archivo, :_destroy]]
          )
        end
end
