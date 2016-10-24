class PartidoStepsController < ApplicationController
    include Wicked::Wizard
    before_action :authenticate_admin!
    before_filter :set_paper_trail_whodunnit
    helper  :all

    respond_to :html, :json, :csv

    before_action :set_partido
    before_action :admin_allowed

    steps   :datos_basicos, :sedes, :personas, :tipo_cargos, :cargos, :administradores,
            :normas_internas,
            :num_afiliados, :tramites,
            :postulacion_popular, :organos_internos, :postulacion_interna,
            :acuerdos_organos,
            :entidades_participadas, :pactos_electorales,
            :linea_denuncia, :sanciones,
            :ingresos_ordinarios, :egresos_ordinarios, :balance_anual, :contrataciones_20utm, :fondos_publicos, :ingresos_campana, :egresos_campana

    def export_personas
      @personas = Persona.where partido: @partido
      respond_to do |f|
        f.csv do
          send_data @personas.to_csv,
            type: "text/csv",
            disposition: 'inline',
            filename: "personas-partido-#{@partido.sigla}-#{Time.now.to_s}.csv"
        end
      end
      #return
    end

    def show

        # @user = current_user
        # @partido = Partido.find_by_user_id(current_user.id)

        ##puts "----------------->  Show::"+current_admin.email
        ##puts "----------------->  Show::"+step.to_s
        case step
        when :datos_basicos

        when :personas

        when :normas_internas

        when :regiones

        when :sedes
            # @partido.regions.each do |r|
            #     if @partido.sedes.find_by_region(r.to_s).blank?
            #         @partido.sedes << Sede.new(region:r)
            #     end
            # end

        when :num_afiliados
            # @partido.regions.each do |r|
            #     if @partido.afiliacions.find_by_region(r.to_s).blank?
            #         @partido.afiliacions << Afiliacion.new(region:r)
            #     end
            # end

        when :tramites
            @partido.tramites.each do |tramite|
                tramite.requisitos.each do |requisito|
                end
                tramite.procedimientos.each do |procedimiento|
                end
            end

        when :linea_denuncia
          tribunal_supremo = @partido.organo_internos.where('lower(nombre) = ?', "Tribunal Supremo".downcase)
          if tribunal_supremo.any?
            if tribunal_supremo.first.contacto.nil? || tribunal_supremo.first.contacto == ''
              @message =  "Por favor rellene el campo contacto del Órgano Interno: Tribunal Supremo."
            else
              @message =  "Las denuncias serán enviadas al contacto del Órgano Interno: Tribunal Supremo. ("+tribunal_supremo.first.contacto+")"
            end
          else
            @message =  "Debe existir un Órgano Interno con nombre \"Tribunal Supremo\"."
          end

        when :administradores
          @admins = @partido.admins
        end
        render_wizard
    end

    def update
        PaperTrail.whodunnit = current_admin.email

        ##puts "----------------->  Update::"+step.to_s
        case step

        when :normas_internas
            PaperTrail.whodunnit = current_admin.email
            @partido.marco_interno.update_attributes(marco_interno_params)
            @partido.marco_interno.save

        when :administradores
          new_admin = Admin.new email: partido_params[:admin][:email].to_s
          new_admin.password = "xxxxxxxx"
          new_admin.password_confirmation = "xxxxxxxx"
          new_admin.save
          @partido.admins << new_admin
          #@partido.admins.map{|a| #puts a.email}

        else
            #PaperTrail.whodunnit = current_admin.email
            @partido.update_attributes(partido_params)
        end
        if request.xhr?
            PaperTrail.whodunnit = current_admin.email

            @partido.save
            @errors = @partido.errors
            @errors.full_messages.each do |message|
            end
        else
          render_wizard @partido
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_partido
          @partido = Partido.find params[:partido_id]
        end

        def admin_allowed
          if  !@partido.admins.include?(current_admin)
            ##puts "admin not allowed admin not allowed admin not allowed admin not allowed admin not allowed "
            redirect_to root_path
          end
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def partido_params
          params.require(:partido).permit(:nombre, :sigla, :lema, :fecha_fundacion, :texto, :logo, :front_logo,
                                                    sedes_attributes: [:id, :region, :direccion, :contacto, :_destroy],
                                                    afiliacions_attributes: [:id, :region_id, :hombres, :mujeres, :otros, :fecha_datos, :ano_nacimiento, :_destroy],
                                                    tramites_attributes: [:id, :nombre, :descripcion, :persona_id, :documento, :_destroy,
                                                              requisitos_attributes: [:descripcion, :id, :_destroy],
                                                              procedimientos_attributes: [:descripcion, :id, :_destroy]],
                                                    representantes_attributes: [:id, :cargo, :nombre, :apellidos, :genero, :fecha_nacimiento, :nivel_estudios,
                                                                :fecha_desde, :fecha_hasta, :email, :telefono,
                                                                :region, :comuna, :circunscripcion, :distrito, :ano_inicio_militancia, :afiliado, :bio, :intereses, :patrimonio, :_destroy],
                                                    candidatos_attributes: [:id, :cargo, :nombre, :apellidos, :genero, :fecha_nacimiento, :nivel_estudios,
                                                                :fecha_desde, :fecha_hasta, :email, :telefono,
                                                                :region, :comuna, :circunscripcion, :distrito, :ano_inicio_militancia, :afiliado, :bio, :intereses, :patrimonio, :_destroy],
                                                    autoridads_attributes: [:id, :cargo, :nombre, :apellidos, :genero, :fecha_nacimiento, :nivel_estudios,
                                                                :fecha_desde, :fecha_hasta, :email, :telefono,
                                                                :region, :comuna, :circunscripcion, :distrito, :ano_inicio_militancia, :afiliado, :bio, :intereses, :patrimonio, :_destroy],
                                                    responsable_denuncias_attributes: [:id, :cargo, :nombre, :apellidos, :genero, :fecha_nacimiento, :nivel_estudios,
                                                                :fecha_desde, :fecha_hasta, :email, :telefono,
                                                                :region, :comuna, :circunscripcion, :distrito, :ano_inicio_militancia, :afiliado, :bio, :intereses, :patrimonio, :_destroy],
                                                    eleccion_populars_attributes: [:id, :fecha_eleccion, :dias, :cargo, :_destroy,
                                                                requisitos_attributes: [:descripcion, :id, :_destroy],
                                                                procedimientos_attributes: [:descripcion, :id, :_destroy]],
                                                    organo_internos_attributes: [:nombre, :funciones, :id, :contacto, :num_integrantes, :_destroy,
                                                                requisitos_attributes: [:descripcion, :id, :_destroy],
                                                                procedimientos_attributes: [:descripcion, :id, :_destroy]],
                                                    eleccion_internas_attributes: [:id, :organo_interno_id, :fecha_eleccion, :fecha_limite_inscripcion, :cargo, :_destroy,
                                                                requisitos_attributes: [:descripcion, :id, :_destroy],
                                                                procedimientos_attributes: [:descripcion, :id, :_destroy]],
                                                    actividad_publicas_attributes: [:id, :fecha, :descripcion, :link, :_destroy],
                                                    acuerdos_attributes: [:id, :numero, :fecha, :tipo, :tema, :region, :organo_interno_id, :documento, :_destroy],
                                                    participacion_entidads_attributes: [:id, :entidad, :documento, :tipo_vinculo, :descripcion, :fecha_inicio, :fecha_fin, :_destroy],
                                                    pacto_electorals_attributes: [:id, :nombre_pacto, :ano_eleccion, :descripcion, :_destroy, :partido_ids => []],
                                                    sancions_attributes: [:id, :descripcion, :institucion, :tipo_sancion, :tipo_infraccion, :fecha, :documento, :_destroy],
                                                    admin: [:email],
                                                    region_ids: []
            )
        end

        def marco_interno_params
          params.require(:marco_interno).permit(:partido_id, documentos_attributes: [:id, :descripcion, :explicacion, :obligatorio, :archivo, :_destroy])
        end
end
