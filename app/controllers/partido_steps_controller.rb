class PartidoStepsController < ApplicationController
    include Wicked::Wizard
    helper  :all
    
    before_action :set_partido
        
    steps :datos_basicos, :normas_internas, :regiones, :sedes, :num_afiliados, :afiliarse, 
    
    :postulacion_popular, :postulacion_interna, :acuerdos, :afiliacion
    
    def show
        @user = current_user
        @partido = Partido.find_by_user_id(current_user.id)
        puts "----------------->  Show::"+step.to_s
        case step
        when :datos_basicos
            
        when :normas_internas
            puts "----------------->  Show::"+step.to_s+"::"+@partido.marco_interno.inspect
        
        when :regiones
            puts "----------------->  Show::"+step.to_s+"::"+@partido.regions.inspect
            
        when :sedes
            @partido.regions.each do |r|
                puts "____________________________________________________>buscando sede de region:"+r.to_s
                if @partido.sedes.find_by_region(r.to_s).blank?
                    puts "____________________________________________________>ENCONTRADA sede de region:"+r.to_s
                    @partido.sedes << Sede.new(region:r)
                end
            end
            puts "----------------->  Show::"+step.to_s+"::"+@partido.sedes.inspect
        
        when :num_afiliados
            @partido.regions.each do |r|
                if @partido.afiliacions.find_by_region(r).blank?
                    @partido.afiliacions << Afiliacion.new(region:r)
                end
            end
            puts "----------------->  Show::"+step.to_s+"::"+@partido.afiliacions.inspect
        
        end
        render_wizard
    end
    
    def update
        # puts params[:partido]
        @partido = Partido.find_by_user_id(current_user.id)
        
        puts "----------------->  Update::"+step.to_s
        case step
        when :datos_basicos
            @partido.update_attributes(partido_params)
            render_wizard @partido
        
        when :normas_internas
            puts marco_interno_params.to_yaml
            @partido.marco_interno.update(marco_interno_params)
            puts "----------------->  Update::"+step.to_s+"::"+@partido.marco_interno.inspect
            render_wizard @partido
        
        when :regiones
            @partido.update_attributes(partido_params)
            
            render_wizard @partido
        
        when :sedes
            puts "----------------->  Update::"+step.to_s+"::"+partido_params.to_yaml
            @partido.update_attributes(partido_params)
            render_wizard @partido
        
        when :num_afiliados
            puts "----------------->  Update::"+step.to_s+"::"+@partido.sedes.to_yaml
            @partido.update_attributes(partido_params)
            render_wizard @partido
                
        end
    end
  
    private
        # Use callbacks to share common setup or constraints between actions.
        def set_partido
          @partido = Partido.find_by_user_id(current_user.id)
        end
    
        # Never trust parameters from the scary internet, only allow the white list through.
        def partido_params
          params.require(:partido).permit(:nombre, :sigla, :lema, :fecha_fundacion, :texto, :logo,
                                                    sedes_attributes: [:id, :region, :direccion, :contacto, :_destroy],
                                                    afiliacions_attributes: [:id, :region, :hombres, :mujeres, :rangos, :_destroy],
                                                    region_ids: []
            )
        end
        
        def marco_interno_params
          params.require(:marco_interno).permit(:partido_id, documentos_attributes: [:id, :descripcion, :archivo, :_destroy])
        end
end
