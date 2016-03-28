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
          
          puts 'raw params--------------------->'
          puts params
          begin
            permitted = params.require(:marco_interno).permit(:partido_id, documentos_attributes: [:id, :descripcion, :archivo, :_destroy])
            m_i_attributes = ActionController::Parameters.new(marco_internos_attributes:permitted)
          rescue
          
          end

          all_params=  ActionController::Parameters.new(partido:m_i_attributes).merge(params)
          puts 'all_params--------------------->'
          puts all_params
          
          partido_params = all_params.require(:partido).permit(:id, :nombre, :sigla, :lema, :fecha_fundacion, :texto, :logo,
          marco_internos_attributes: [:id, :partido_id, documentos_attributes: [:id, :descripcion, :archivo, :_destroy]]
          )
          
          puts 'partido_params--------------------->'
          puts partido_params
          
          partido_params

        end
end
