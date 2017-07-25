class PartidosController < ApplicationController
  include PartidosHelper
  before_action :authenticate_admin!, only: [:new, :edit, :create, :update, :destroy, :admin]
  before_filter :authenticate_superadmin, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_partido, except: [:index, :new, :create, :admin]
  before_action :get_partidos, except: [:index, :new, :create, :admin]
  before_action :set_menu
  before_action :set_fecha_datos
  layout "frontend", only: [:normas_internas, :regiones_all, :sedes_partido, :autoridades,
                            :vinculos_intereses, :pactos, :sanciones,
                            :finanzas_1, :finanzas_2, :finanzas_5, :ingresos_campana, :egresos_campana,
                            :contrataciones_20utm, :afiliacion_desafiliacion, :eleccion_popular,
                            :organos_internos, :elecciones_internas, :representantes,
                            :acuerdos_organos, :estructura_organica, :actividades_publicas,
                            :intereses_patrimonios, :publicacion_candidatos, :resultado_elecciones_internas
                          ]


  # GET /partidos
  # GET /partidos.json
  def index
    @partidos = Partido.all
  end

  def admin
    # if admin_signed_in?
    @partidos = current_admin.partidos
    if current_admin.is_superadmin?
      @login_data = []

      Admin.order(last_sign_in_at: :desc).each do |admin|
        admin_logins = AdminLogin.where admin: admin
        logins = []
        admin_logins.order(fecha: :desc).limit(3).each do |login|
          logins << {fecha: login.fecha, ip: login.ip}
        end
        last_actions = PaperTrail::Version.where(:whodunnit => admin.email).last(3)
        @login_data << {email: admin.email, is_superadmin: admin.is_superadmin, login_count: admin_logins.count, logins: logins, last_actions: last_actions}
      end

      ###puts @login_data
    end

    # else
    #   redirect_to new_admin_session_path
    # end
  end

  # GET /partidos/1
  # GET /partidos/1.json
  def show

    @datos_region = []
    @datos_sedes = []
    @datos_cargos = []
    region = {}

    @partido.regions.each do |r|
      afiliados = Afiliacion.where(partido_id: @partido, region_id: r)

      h = 0
      m = 0
      ph = 0
      pm = 0
      afiliados.each do |a|
        h = h + a.hombres
        m = m + a.mujeres
        total = h+m
        ph = (h*100)/total
        pm = (m*100)/total
      end
      region = { 'region' => r.nombre, 'ordinal' => r.ordinal, 'hombres' => h, 'porcentaje_hombres' => ph, 'mujeres' => m, 'porcentaje_mujeres' => pm }
      @datos_region.push region

      sedes = @partido.sedes.where(region_id: r)
      all_sedes = []
      sedes.each do |s|
        all_sedes.push( { 'direccion' => s.direccion, 'contacto' => s.contacto, 'comuna' => s.comuna.nombre } )
      end
      @datos_sedes.push( {'region' => r.nombre, 'sedes' => all_sedes} )

      cargos = @partido.cargos.where(region_id: r)
      all_cargos = []
      cargos.each do |c|
        all_cargos.push( { 'persona' => c.persona.nombre, 'cargo' => c.tipo_cargo.titulo, 'comuna' => c.comuna.nombre } )
      end
      @datos_cargos.push( {'region' => r.nombre, 'cargos' => all_cargos} )
    end


  end

  # GET /partidos/new
  def new
    @partido = Partido.new
  end

  # GET /partidos/1/edit
  def edit
    @partido = Partido.find_by id: params[:id]
    # unless @partido.user == current_user
    #   flash[:notice] = "Not allowed to update partido " + @partido.nombre
    #   redirect_to root_path
    # end
  end

  # POST /partidos
  # POST /partidos.json
  def create
    PaperTrail.whodunnit = current_admin.email
    @partido = Partido.new(partido_params)
    # @partido.user = current_user

    respond_to do |format|
      if @partido.save
        # format.html { redirect_to @partido, notice: 'Partido was successfully created.' }
        format.html { redirect_to partido_steps_path(@partido),  notice: 'Partido was successfully created.' }
        format.json { render :show, status: :created, location: @partido }
      else
        format.html { render :new }
        format.json { render json: @partido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /partidos/1
  # PATCH/PUT /partidos/1.json
  def update
    PaperTrail.whodunnit = current_admin.email
    respond_to do |format|
      if @partido.update(partido_params)
        format.html { redirect_to @partido, notice: 'Partido was successfully updated.' }
        format.json { render :show, status: :ok, location: @partido }
      else
        format.html { render :edit }
        format.json { render json: @partido.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /partidos/1
  # DELETE /partidos/1.json
  def destroy
    PaperTrail.whodunnit = current_admin.email
    @partido.destroy
    respond_to do |format|
      format.html { redirect_to partidos_url, notice: 'Partido was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def normas_internas
    @normas_internas = []
    unless @partido.marco_interno.nil?
      @partido.marco_interno.documentos.each do |d|
        if !d.archivo_file_name.nil?
          @normas_internas.push d
        end
      end
    end
  end

  # def regiones
  #   rangos = [[14,17],[18,24],[25,29],[30,34],[35,39],[40,44],[45,49],[50,54],[55,59],[60,64],[65,69],[70,100]]
  #   @datos_region = []
  #   @datos_nacional = []
  #   @rangos_edad = []
  #
  #   nh = 0 #nacional hombres
  #   nm = 0 #nacional mujeres
  #   no = 0
  #   rh = 0 #regional hombres
  #   rm = 0 #regional mujeres
  #   ro = 0
  #   pnh = 0 #promedio nacional hombres
  #   pnm = 0 #promedio nacional mujeres
  #   pno = 0
  #
  #   nacional = { "region" => "nacional",
  #                "ordinal" => "nacional",
  #                "hombres" => 0,
  #                "mujeres" => 0,
  #                "otros" => 0,
  #                "porcentaje_hombres" => 0,
  #                "porcentaje_mujeres" => 0,
  #                "porcentaje_otros" => 0,
  #                "total" => 0,
  #                "desgloce" => [] }
  #
  #   last_date = Afiliacion.where(partido_id: @partido).uniq.pluck(:fecha_datos).sort.last
  #
  #   autoridad = @partido.tipo_cargos.where(:autoridad => true)
  #   cargo_interno = @partido.tipo_cargos.where(:cargo_interno => true)
  #   representante = @partido.tipo_cargos.where(:representante => true)
  #
  #   @partido.regions.each do |r|
  #     afiliados = Afiliacion.where(partido_id: @partido, region_id: r, fecha_datos: last_date)
  #     # if afiliados.any?
  #       h = 0 #hombres
  #       m = 0 #mujeres
  #       o = 0
  #       rh = 0 #hombres
  #       rm = 0 #mujeres
  #       ro = 0
  #       ph = 0 #promedio hombres
  #       pm = 0 #promedio mujeres
  #       po = 0
  #       afiliados.each do |a|
  #         h = h + a.hombres
  #         m = m + a.mujeres
  #         o = o + a.otros
  #         total = a.total
  #         if(total>0)
  #           ph = (h*100)/total
  #           pm = (m*100)/total
  #           po = (o*100)/total
  #         end
  #       end
  #       if(h>0 || m>0 || o>0)
  #         nh = nh + h #nacional hombres
  #         nm = nm + m #nacional mujeres
  #         no = no + o #nacional otros
  #         rh = rh + h #regional hombres
  #         rm = rm + m #regional mujeres
  #         ro = ro + o #regional otros
  #         total_n = nh + nm + no #total nacional
  #         total_r = rh + rm + ro #total regional
  #         pnh = (nh*100)/total_n #promedio nacional hombres
  #         pnm = (nm*100)/total_n #promedio nacional mujeres
  #         pno = (no*100)/total_n #promedio nacional otros
  #
  #         region = { "region" => r.nombre, "ordinal" => r.ordinal, "hombres" => h + 0.000001, "porcentaje_hombres" => ph, "mujeres" => m + 0.000001, "porcentaje_mujeres" => pm, "otros" => o + 0.000001, "porcentaje_otros" => po, "total" => total_r, "desgloce" => [], "cargos" => [] }
  #
  #         region["cargos"] << {"type" => "autoridad", "nro_cargos" => @partido.cargos.where(:tipo_cargo_id => autoridad, :region_id => r).count}
  #         region["cargos"] << {"type" => "cargo_interno", "nro_cargos" => @partido.cargos.where(:tipo_cargo_id => cargo_interno, :region_id => r).count}
  #         region["cargos"] << {"type" => "representante", "nro_cargos" => @partido.cargos.where(:tipo_cargo_id => representante, :region_id => r).count}
  #
  #         participantes = 0
  #         rangos.each do |rango|
  #           participantes = @partido.afiliacions.where(:ano_nacimiento => Date.today.year-rango[1]..Date.today.year-rango[0], :region_id => r, fecha_datos: last_date)
  #           ph = 0.0001 #participantes hombres
  #           pm = 0.0001 #participantes mujeres
  #           po = 0.0001
  #           participantes.each do |np|
  #             ph = ph + np.hombres
  #             pm = pm + np.mujeres
  #             po = po + np.otros
  #           end
  #           region["desgloce"].push( rango[0].to_s+'-'+rango[1].to_s => ph + pm + po )
  #         end
  #         @datos_region.push region
  #       end
  #     # end
  #
  #   end
  #
  #   nacional = { "region" => "nacional", "ordinal" => "nacional", "hombres" => nh + 0.000001, "mujeres" => nm + 0.000001, "otros" => no + 0.000001, "porcentaje_hombres" => pnh, "porcentaje_mujeres" => pnm, "porcentaje_otros" => pno, "total" => nh + nm + no, "desgloce" => [], "cargos" => [] }
  #   a = []
  #   if @datos_region.any?
  #
  #     @datos_region.each do |dr|
  #       dr["desgloce"].each do |d|
  #         a << d
  #       end
  #     end
  #     nacional["desgloce"] << a.inject{ |x,y| x.merge(y) { |k,old_v, new_v| old_v+new_v } }
  #   end
  #
  #   nacional["cargos"] << {"type" => "autoridad", "nro_cargos" => @partido.cargos.where(:tipo_cargo_id => autoridad).count}
  #   nacional["cargos"] << {"type" => "cargo_interno", "nro_cargos" => @partido.cargos.where(:tipo_cargo_id => cargo_interno).count}
  #   nacional["cargos"] << {"type" => "representante", "nro_cargos" => @partido.cargos.where(:tipo_cargo_id => representante).count}
  #
  #   @datos_nacional.push nacional
  #
  #   @datos_total_nacional = @datos_nacional + @datos_region
  # end

  def regiones_all
    @datos_nacional = []

    temp_trimestres_informados = []
    @partido.sedes.each do |s|
      s.trimestre_informados.each do |t|

        temp_trimestres_informados.push(t)

      end
    end

    @trimestres_informados = temp_trimestres_informados.uniq.sort_by {|t| t.ano.to_s + t.ordinal.to_s}
    @trimestres_informados.reverse!

    if (@trimestres_informados.count == 0 || @partido.afiliacions.last == nil)
      @trimestres_informados = []
      @cantidad_afiliados = []
      @sin_datos = true
    else
      params[:trimestre_informado_id] = @trimestres_informados.first.id if params[:trimestre_informado_id].nil?
      @trimestre_informado = TrimestreInformado.find(params[:trimestre_informado_id])

      if @trimestre_informado.afiliacions.where(:partido_id => @partido.id,
                                                :rango_etareo => "Total Militantes").first.nil?

        @sin_info_afiliados = true
      else
        # @cantidad_afiliados = @partido.afiliacions.last.total
        @cantidad_afiliados = @trimestre_informado.afiliacions.where(:partido_id => @partido.id,
                                             :rango_etareo => "Total Militantes").first.total_afiliados
        @sin_info_afiliados = false
      end
      @sin_datos = false
      p 'CANTIDAD DE AFILIADOS >' + @cantidad_afiliados.to_s + '<'
      if @cantidad_afiliados.nil?
        @cantidad_afiliados = 'El partido no ha entregado
         la información correspondiente al trimestre consultado'
      end
    end
  end

  def sedes_partido

    temp_trimestres_informados = []
    @partido.sedes.each do |s|
      s.trimestre_informados.each do |t|

        temp_trimestres_informados.push(t)

      end
    end

    @trimestres_informados = temp_trimestres_informados.uniq.sort_by {|t| t.ano.to_s + t.ordinal.to_s}
    @trimestres_informados.reverse!

    if @trimestres_informados.count == 0
      @trimestres_informados = []
      @datos_sedes = []
      @sin_datos = true
    else
      params[:trimestre_informado_id] = @trimestres_informados.first.id if params[:trimestre_informado_id].nil?
      @trimestre_informado = TrimestreInformado.find(params[:trimestre_informado_id])

      @datos_sedes = []
      region_ids_with_sede = @partido.sedes.select(:region_id).uniq.map(&:region_id)
      region_ids_with_sede.each do |r|
        # sedes = @trimestre_informado.sedes.where(region_id: r)
        sedes = @trimestre_informado.sedes.where(region_id: r).where(partido_id: @partido.id)
        all_sedes = []
        sedes.each do |s|
          all_sedes.push( { 'direccion' => s.direccion, 'contacto' => s.contacto, 'comuna' => s.comuna.nombre } )
        end
        region = Region.find r
        @datos_sedes.push( {'region' => region.nombre, 'sedes' => all_sedes} )
        @sin_datos = false
      end
    end
  end

  def autoridades
    @autoridades = []
    t_cargos = @partido.tipo_cargos.where(autoridad: true)
    if t_cargos.count == 0
      @sin_datos = true
    else
      t_cargos.each do |tc|
        cargos = @partido.cargos.where(tipo_cargo_id: tc)
        if !params["region"].blank?
          cargos = cargos.where(region_id: params["region"])
        end
        if !params["genero"].blank?
          personas_id = @partido.personas.where(genero: params["genero"])
          cargos = cargos.where(persona_id: personas_id)
        end
        if !params["q"].blank?
          n = params[:q].split(" ")[0]
          a = params[:q].split(" ")[1] || params[:q].split(" ")[0]
          personas_id = Persona.where("lower(personas.nombre) like ? OR lower(personas.apellidos) like ?", n.downcase, a.downcase)
          cargos = cargos.where(persona_id: personas_id)
        end
        @autoridades << {"type" => tc.titulo, "cargos" => cargos}
      end
      @sin_datos = false
    end
  end

  def vinculos_intereses
    @entidades = []
    @partido.participacion_entidads.each do |p|
      @entidades.push p
    end
    if @entidades.count == 0
      @sin_datos = true
    else
      @sin_datos = false
    end
  end

  def pactos
    @pactos = []
    @partido.pacto_electorals.each do |p|
      @pactos.push p
    end
    if @pactos.count == 0
      @sin_datos = true
    else
      @sin_datos = false
    end
  end

  # MÉTODO ANTIGUO
  # def sanciones
  #   @sanciones = []
  #   @partido.sancions.each do |s|
  #     @sanciones.push s
  #   end
  #   if @sanciones.count == 0
  #     @sin_datos = true
  #   else
  #     @sin_datos = false
  #   end
  # end

  def sanciones

    temp_trimestres_informados = []
    @partido.sancions.each do |s|
      s.trimestre_informados.each do |t|

        temp_trimestres_informados.push(t)

      end
    end

    @trimestres_informados = temp_trimestres_informados.uniq.sort_by {|t| t.ano.to_s + t.ordinal.to_s}
    @trimestres_informados.reverse!

    if @trimestres_informados.count == 0
      @trimestres_informados = []
      @sanciones = []
      @sin_datos = true
    else
      params[:trimestre_informado_id] = @trimestres_informados.first.id if params[:trimestre_informado_id].nil?
      @trimestre_informado = TrimestreInformado.find(params[:trimestre_informado_id])

      sanciones = @trimestre_informado.sancions.where(:partido_id => @partido.id)

      @sanciones = []
      sanciones.each do |s|
        @sanciones.push(s)
        p s
      end
      @sin_datos = false
    end
  end

  def finanzas_1
    # @fechas_datos = IngresoOrdinario.where(partido: @partido).uniq.pluck(:fecha_datos).sort
    # if params[:fecha_datos]
    #   @fecha = Date.new(params[:fecha_datos].split("-")[0].to_i, params[:fecha_datos].split("-")[1].to_i, params[:fecha_datos].split("-")[2].to_i)
    # else
    #   @fecha = @fechas_datos.last
    # end

    temp_trimestres_informados = []
    @partido.ingreso_ordinarios.each do |io|
      io.trimestre_informados.each do |t|

        temp_trimestres_informados.push(t)

      end
    end

    @trimestres_informados = temp_trimestres_informados.uniq.sort_by {|t| t.ano.to_s + t.ordinal.to_s}
    @trimestres_informados.reverse!

    if @trimestres_informados.count == 0
      @trimestres_informados = []
      @datos_ingresos_ordinarios = []
      # line ={ 'text'=> 'Sin información', 'value' => 0, 'percentage' => 0 }
      # @datos_ingresos_ordinarios << line
      @datos_ingresos_ordinarios_totals = {'publicos' => 0, 'privados' => 0}
      @sin_datos = true
    else
      params[:trimestre_informado_id] = @trimestres_informados.first.id if params[:trimestre_informado_id].nil?
      @trimestre_informado = TrimestreInformado.find(params[:trimestre_informado_id])

      ingresos_ordinarios = @trimestre_informado.ingreso_ordinarios.where(:partido_id => @partido.id)

      total_publicos = ingresos_ordinarios.where(:partido_id => @partido.id,
                                                 :concepto => (["Aportes del Estado (Art. 33 Bis Ley N° 18603)",
                                                                "Otras transferencias públicas"])).sum(:importe) rescue 0
      total_privados = ingresos_ordinarios.where(:partido_id => @partido.id,
                                                 :concepto => (["Cotizaciones",
                                                                 "Donaciones",
                                                                 "Asignaciones testamentarias",
                                                                 "Frutos y productos de los bienes patrimoniales",
                                                                 "Otras transferencias privadas",
                                                                 "Ingresos militantes"])).sum(:importe) rescue 0
      max_value = total_publicos + total_privados
      @datos_ingresos_ordinarios = []
      ingresos_ordinarios.each do |io|
        val = ((io.importe.to_f / max_value.to_f).to_f rescue 0).to_s
        line ={ 'text'=> io.concepto,
                'value' => ActiveSupport::NumberHelper::number_to_delimited(io.importe,
                                                                            delimiter: ""),
                'percentage' => val }
        @datos_ingresos_ordinarios << line unless io.importe == 0
      end

      @datos_ingresos_ordinarios_totals = { 'publicos'=> total_publicos, 'privados' => total_privados}
      @sin_datos = false
    end
  end

  def ingresos_campana

    temp_trimestres_informados = []
    @partido.ingreso_campanas.each do |ic|
      ic.trimestre_informados.each do |t|

        temp_trimestres_informados.push(t)

      end
    end

    @trimestres_informados = temp_trimestres_informados.uniq.sort_by {|t| t.ano.to_s + t.ordinal.to_s}
    @trimestres_informados.reverse!

    if @trimestres_informados.count == 0
      @trimestres_informados = []
      @datos_ingresos_campanas = []
      @datos_ingresos_campanas_totals = {'aportes_en_dinero' => 0, 'otros_aportes' => 0}
      @sin_datos = true
    else
      params[:trimestre_informado_id] = @trimestres_informados.first.id if params[:trimestre_informado_id].nil?
      @trimestre_informado = TrimestreInformado.find(params[:trimestre_informado_id])

      ingresos_campanas = @trimestre_informado.ingreso_campanas.where(:partido_id => @partido.id)

      monto_aporte_dinero = ingresos_campanas.where(:partido_id => @partido.id,
                                                    :tipo_aporte => (["Aportes en Dinero"])).sum(:monto) rescue 0

      monto_otro_aporte = ingresos_campanas.where(:partido_id => @partido.id).where.not(:tipo_aporte => ["Aportes en Dinero"]).sum(:monto) rescue 0

      max_value = monto_aporte_dinero + monto_otro_aporte
      @datos_ingresos_campanas = []
      line = {'text' => 0,
              'value' => 0,
              'percentage' => 0}
      monto = 0

      ingresos_campanas.each do |ic|
        if ic.tipo_aporte != "Aportes en Dinero"
          val = ((ic.monto.to_f / max_value.to_f).to_f rescue 0).to_s
          ic.tipo_aporte = ic.tipo_aporte.titleize
          line = { 'text' => ic.tipo_aporte,
                   'value' => ActiveSupport::NumberHelper::number_to_delimited(ic.monto,
                                                                               delimiter: ""),
                   'percentage' => val }
            @datos_ingresos_campanas << line
        elsif ic.tipo_aporte == "Aportes en Dinero"
          monto += ic.monto
          val = ((monto.to_f / max_value.to_f).to_f rescue 0).to_s
          line ={ 'text'=> ic.tipo_aporte,
                  'value' => ActiveSupport::NumberHelper::number_to_delimited(monto,
                                                                              delimiter: ""),
                  'percentage' => val }
          p "Line aportes en dinero: " + line.to_s
          unless (monto == 0 || monto < monto_aporte_dinero)
            @datos_ingresos_campanas << line
          end
        end
      end


      @datos_ingresos_campanas_totals = { 'aportes_en_dinero'=> monto_aporte_dinero, 'otros_aportes' => monto_otro_aporte}
      @sin_datos = false
    end
  end

  def contrataciones_20utm

    temp_trimestres_informados = []
    @partido.contratacions.each do |c|
      c.trimestre_informados.each do |t|

        temp_trimestres_informados.push(t)
      end
    end

    @trimestres_informados = temp_trimestres_informados.uniq.sort_by {|t| t.ano.to_s + t.ordinal.to_s}
    @trimestres_informados.reverse!

    if @trimestres_informados.count == 0
      @trimestres_informados = []
      @datos_contrataciones = []
      @datos_contrataciones_totals = []
      @sin_datos = true
    else
      params[:trimestre_informado_id] = @trimestres_informados.first.id if params[:trimestre_informado_id].nil?
      @trimestre_informado = TrimestreInformado.find(params[:trimestre_informado_id])

      contrataciones = @trimestre_informado.contratacions.where(:partido_id => @partido.id)
      .select('extract(year from fecha_inicio) as year, extract(month from fecha_inicio) as month, sum(monto)')
      .group('extract(year from fecha_inicio), extract(month from fecha_inicio)')
      .order('extract(year from fecha_inicio), extract(month from fecha_inicio)')

      max_value = 0
      contrataciones.each do |c|
        if c.year == @trimestre_informado.ano

          mes = get_month(c.month.round(0))
          max_value = max_value_contrataciones_20utm(@trimestre_informado,
                                                     mes, c, max_value)
          # p max_value.to_s
        end
      end

      if max_value < 0
        max_value = max_value * -1
      end

      primer_mes = 0
      segundo_mes = 0
      tercer_mes = 0
      total = 0
      @datos_contrataciones = []

      contrataciones.each do |tr|

        if tr.sum < 0
          tr.sum = tr.sum * -1
        end

        if tr.year == @trimestre_informado.ano
          año = tr.year.round(0).to_s
          if @trimestre_informado.ordinal == 0
            mes = get_month(tr.month.round(0))
            if mes.include?("Enero")
              primer_mes = tr.sum
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += primer_mes
            elsif mes.include?("Febrero")
              segundo_mes = tr.sum
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += segundo_mes
            elsif mes.include?("Marzo")
              tercer_mes = tr.sum
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += tercer_mes
            end
          elsif @trimestre_informado.ordinal == 1
            mes = get_month(tr.month.round(0))
            if mes.include?("Abril")
              primer_mes = tr.sum
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += primer_mes
            elsif mes.include?("Mayo")
              segundo_mes = tr.sum
              año = tr.year.round(0).to_s
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += segundo_mes
            elsif mes.include?("Junio")
              tercer_mes = tr.sum
              año = tr.year.round(0).to_s
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += tercer_mes
            end
          elsif @trimestre_informado.ordinal == 2
            mes = get_month(tr.month.round(0))
            if mes.include?("Julio")
              primer_mes = tr.sum
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += primer_mes
            elsif mes.include?("Agosto")
              segundo_mes = tr.sum
              año = tr.year.round(0).to_s
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += segundo_mes
            elsif mes.include?("Septiembre")
              tercer_mes = tr.sum
              año = tr.year.round(0).to_s
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += tercer_mes
            end
          elsif @trimestre_informado.ordinal == 3
            mes = get_month(tr.month.round(0))
            if mes.include?("Octubre")
              primer_mes = tr.sum
              año = tr.year.round(0).to_s
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += primer_mes
            elsif mes.include?("Noviembre")
              segundo_mes = tr.sum
              año = tr.year.round(0).to_s
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += segundo_mes
            elsif mes.include?("Diciembre")
              tercer_mes = tr.sum
              año = tr.year.round(0).to_s
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += tercer_mes
            end
          end
        end

        if !line.nil?
          @datos_contrataciones << line
        end
      end

      @datos_contrataciones_totals = { :total => total,
                                       :primer_mes => primer_mes,
                                       :segundo_mes => segundo_mes,
                                       :tercer_mes => tercer_mes }

      if @datos_contrataciones_totals[:total] < 0
        @datos_contrataciones_totals[:total] = @datos_contrataciones_totals[:total] * -1
      end

      @sin_datos = false
    end
  end

  def egresos_campana

    temp_trimestres_informados = []
    @partido.egreso_campanas.each do |ec|
      ec.trimestre_informados.each do |t|

        temp_trimestres_informados.push(t)

      end
    end

    @trimestres_informados = temp_trimestres_informados.uniq.sort_by {|t| t.ano.to_s + t.ordinal.to_s}
    @trimestres_informados.reverse!

    @datos_egresos_campanas = []
    @datos_egresos_campanas_totals = {'alcaldicia' => 0,
      'concejal' => 0,
      'diputados' => 0,
      'presidencial' => 0,
      'senatorial' => 0,
      'consejeros_regionales' => 0}

    if @trimestres_informados.count == 0
      @trimestres_informados = []
      @sin_datos = true
    else
      params[:trimestre_informado_id] = @trimestres_informados.first.id if params[:trimestre_informado_id].nil?
      @trimestre_informado = TrimestreInformado.find(params[:trimestre_informado_id])

      egresos_campanas = @trimestre_informado.egreso_campanas.where(:partido_id => @partido.id)


      montos = {}
      total = 0
      max_value = 0

      tipos_campanas = egresos_campanas.all.map{|c| c.tipo_campana}.uniq

      tipos_campanas.each do |tipoc|
        montos[:tipoc] = egresos_campanas.where(:tipo_campana => tipoc).sum(:monto)
        @datos_egresos_campanas << {:text => tipoc,
                                    :value => ActiveSupport::NumberHelper::number_to_delimited(montos[:tipoc],
                                                                                            delimiter: ""),
                                    :percentage => 0.2 }
      end

      @datos_egresos_campanas.each do |dato_e_c|
        total += dato_e_c[:value].to_f
        if dato_e_c[:value].to_f > max_value
          max_value = dato_e_c[:value].to_f
        end
      end

      @datos_egresos_campanas.each do |dato_e_c|
        val = ((dato_e_c[:value].to_f / total.to_f).to_f rescue 0).to_s
        dato_e_c[:percentage] = val
        @datos_egresos_campanas_totals[dato_e_c[:text].downcase.gsub(' ','_')] = dato_e_c[:value]
      end

      p @datos_egresos_campanas_totals




      @sin_datos = false
    end
  end

  # def finanzas_2
  #   @fechas_datos = EgresoOrdinario.where(partido: @partido).uniq.pluck(:fecha_datos).sort
  #   if params[:fecha_datos]
  #     @fecha = Date.new(params[:fecha_datos].split("-")[0].to_i, params[:fecha_datos].split("-")[1].to_i, params[:fecha_datos].split("-")[2].to_i)
  #   else
  #     @fecha = @fechas_datos.last
  #   end
  #   egresos_ordinarios = EgresoOrdinario.where(:partido => @partido, :fecha_datos => @fecha )
  #   if egresos_ordinarios.count == 0
  #     @sin_datos = true
  #   else
  #     max_value = egresos_ordinarios.maximum("privado + publico")
  #     @datos_egresos_ordinarios = []
  #     egresos_ordinarios.each do |eo|
  #       val = (100 * ((eo.publico.to_f + eo.privado.to_f)/ max_value.to_f).to_f rescue 0).to_s
  #       line ={ 'text'=> eo.concepto, 'value_publico' => eo.publico, 'value_privado' => eo.privado,
  #               'value' => ActiveSupport::NumberHelper::number_to_delimited(eo.privado + eo.publico, delimiter: ""), 'percentage' => val }
  #       @datos_egresos_ordinarios << line
  #     end
  #     total_publicos = egresos_ordinarios.sum(:publico)
  #     total_privados = egresos_ordinarios.sum(:privado)
  #     @datos_egresos_ordinarios_totals = { 'publicos'=> total_publicos, 'privados' => total_privados}
  #     @sin_datos = false
  #   end
  # end

  def finanzas_2

    temp_trimestres_informados = []
    @partido.egreso_ordinarios.each do |eo|
      eo.trimestre_informados.each do |t|

        temp_trimestres_informados.push(t)

      end
    end

    @trimestres_informados = temp_trimestres_informados.uniq.sort_by {|t| t.ano.to_s + t.ordinal.to_s}
    @trimestres_informados.reverse!

    if @trimestres_informados.count == 0
      @trimestres_informados = []
      @datos_egresos_ordinarios = []
      @datos_egresos_ordinarios_totals = {'publicos' => 0, 'privados' => 0}
      @sin_datos = true
    else
      params[:trimestre_informado_id] = @trimestres_informados.first.id if params[:trimestre_informado_id].nil?
      @trimestre_informado = TrimestreInformado.find(params[:trimestre_informado_id])

      egresos_ordinarios = @trimestre_informado.egreso_ordinarios.where(:partido_id => @partido.id)


      ga = egresos_ordinarios.where(:partido_id => @partido.id,
                                    :concepto => (["Gastos de personal",
                                                   "Gastos de adquisición de bienes y servicios o gastos corrientes",
                                                   "Otros gastos de administración"]))

      gci = egresos_ordinarios.where(:partido => @partido.id,
                                     :concepto => (["Gastos financieros por préstamos de corto plazo",
                                                    "Gastos financieros por préstamos de largo plazo",
                                                    "Créditos de corto plazo, inversiones y valores de operaciones de capital",
                                                    "Créditos de largo plazo, inversiones y valores de operaciones de capital"]))

      gf = egresos_ordinarios.where(:partido => @partido.id,
                                    :concepto => (["Gastos de actividades de investigación",
                                                   "Gastos de actividades de educación cívica",
                                                   "Gastos de actividades de fomento a la particiación femenina",
                                                   "Gastos de actividades de fomento a la participación de los jóvenes",
                                                   "Gastos de las actividades de preparación de candidatos a cargos de elección popular",
                                                   "Gastos de las actividades de formación de militantes"]))


      gastos_administracion = gasto_por_trimeste(@trimestre_informado, ga)
      gastos_creditos_inversiones = gasto_por_trimeste(@trimestre_informado, gci)
      gastos_formacion = gasto_por_trimeste(@trimestre_informado, gf)
      max_value = gastos_administracion + gastos_creditos_inversiones + gastos_formacion

      @datos_egresos_ordinarios =[]
      egresos_ordinarios.each do |eo|
        val = val_egresos_ordinarios(@trimestre_informado, eo, max_value)
        line = line_egresos_ordinarios(@trimestre_informado,eo, val)
      end

      @datos_egresos_ordinarios_totals = {'gastos_administracion' => gastos_administracion,
                                          'gastos_creditos_inversiones' => gastos_creditos_inversiones,
                                          'gastos_formacion' => gastos_formacion}
      @sin_datos = false
    end
  end

  # MÉTODO ANTIGUO
  # def finanzas_5
  #   @fechas_datos = Transferencia.where(partido: @partido).uniq.pluck(:fecha_datos).sort
  #   if params[:fecha_datos]
  #     @fecha = Date.new(params[:fecha_datos].split("-")[0].to_i, params[:fecha_datos].split("-")[1].to_i, params[:fecha_datos].split("-")[2].to_i)
  #   else
  #     @fecha = @fechas_datos.last
  #   end
  #
  # datos_eficientes_transferencias = Transferencia.where(partido: @partido, :fecha_datos => @fecha).group(:categoria).
  # select("categoria, count(1) as count, sum(monto) as total").order(:categoria)
  #
  #   max_value = Transferencia.where(partido: @partido, :fecha_datos => @fecha).group(:categoria).select("sum(monto) as total").order("total DESC").first.attributes.symbolize_keys![:total] rescue 0
  #
  #
  #   datos_eficientes_transferencias.each do |d|
  #     d.attributes.symbolize_keys!
  #   end
  #   total = 0
  #   @datos_transferencias = []
  #   datos_eficientes_transferencias.each do |t|
  #     total = total + t.total
  #     val = (100 * ((t.total.to_f)/ max_value.to_f).to_f rescue 0).to_s
  #     line ={ 'text'=> t.categoria,
  #       'value' => ActiveSupport::NumberHelper::number_to_delimited(t.total, delimiter: "."), 'percentage' => val }
  #     @datos_transferencias << line
  #   end
  #   @datos_transferencias_totals = { :total => total }
  # end

  def finanzas_5

    temp_trimestres_informados = []
    @partido.transferencias.each do |tr|
      tr.trimestre_informados.each do |t|

        temp_trimestres_informados.push(t)
      end
    end

    @trimestres_informados = temp_trimestres_informados.uniq.sort_by {|t| t.ano.to_s + t.ordinal.to_s}
    @trimestres_informados.reverse!

    if @trimestres_informados.count == 0
      @trimestres_informados = []
      @datos_transferencias_totals = []
      @sin_datos = true
    else
      params[:trimestre_informado_id] = @trimestres_informados.first.id if params[:trimestre_informado_id].nil?
      @trimestre_informado = TrimestreInformado.find(params[:trimestre_informado_id])

      temp_transferencias = @trimestre_informado.transferencias.where(:partido_id => @partido.id)
      .select('extract(year from fecha) as year, extract(month from fecha) as month, sum(monto)')
      .group('extract(year from fecha),extract(month from fecha)')
      .order('extract(year from fecha),extract(month from fecha)')

      max_value = 0
      temp_transferencias.each do |tr|
        if tr.year == @trimestre_informado.ano

          mes = get_month(tr.month.round(0))
          max_value = max_value_transferencias_fondos_publicos(@trimestre_informado,
                                                                mes, tr, max_value)
        end
      end

      if max_value < 0
        max_value = max_value * -1
      end

      primer_mes = 0
      segundo_mes = 0
      tercer_mes = 0
      total = 0
      @datos_transferencias = []

      temp_transferencias.each do |tr|

        if tr.sum < 0
          tr.sum = tr.sum * -1
        end

        if tr.year == @trimestre_informado.ano
          año = tr.year.round(0).to_s
          if @trimestre_informado.ordinal == 0
            mes = get_month(tr.month.round(0))
            if mes.include?("Enero")
              primer_mes = tr.sum
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += primer_mes
            elsif mes.include?("Febrero")
              segundo_mes = tr.sum
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += segundo_mes
            elsif mes.include?("Marzo")
              tercer_mes = tr.sum
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += tercer_mes
            end
          elsif @trimestre_informado.ordinal == 1
            mes = get_month(tr.month.round(0))
            if mes.include?("Abril")
              primer_mes = tr.sum
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += primer_mes
            elsif mes.include?("Mayo")
              segundo_mes = tr.sum
              año = tr.year.round(0).to_s
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += segundo_mes
            elsif mes.include?("Junio")
              tercer_mes = tr.sum
              año = tr.year.round(0).to_s
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += tercer_mes
            end
          elsif @trimestre_informado.ordinal == 2
            mes = get_month(tr.month.round(0))
            if mes.include?("Julio")
              primer_mes = tr.sum
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += primer_mes
            elsif mes.include?("Agosto")
              segundo_mes = tr.sum
              año = tr.year.round(0).to_s
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += segundo_mes
            elsif mes.include?("Septiembre")
              tercer_mes = tr.sum
              año = tr.year.round(0).to_s
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += tercer_mes
            end
          elsif @trimestre_informado.ordinal == 3
            mes = get_month(tr.month.round(0))
            if mes.include?("Octubre")
              primer_mes = tr.sum
              año = tr.year.round(0).to_s
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += primer_mes
            elsif mes.include?("Noviembre")
              segundo_mes = tr.sum
              año = tr.year.round(0).to_s
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += segundo_mes
            elsif mes.include?("Diciembre")
              tercer_mes = tr.sum
              año = tr.year.round(0).to_s
              val = (((tr.sum.to_f)/ max_value.to_f).to_f rescue 0).to_s
              line = {'text'=> mes +' de ' + año, 'value' => tr.sum, 'percentage' => val}
              total += tercer_mes
            end
          end
        end

        if !line.nil?
          @datos_transferencias << line
        end
      end

      @datos_transferencias_totals = { :total => total,
                                       :primer_mes => primer_mes,
                                       :segundo_mes => segundo_mes,
                                       :tercer_mes => tercer_mes }

      if @datos_transferencias_totals[:total] < 0
        @datos_transferencias_totals[:total] = @datos_transferencias_totals[:total] * -1
      end

      @sin_datos = false
    end
  end

  def afiliacion_desafiliacion
    @tramites = @partido.tramites
    @sin_datos = true
  end

  def eleccion_popular

    cargos = %w(Presidente Senador Diputado Consejero\ Regional Alcalde Concejal)
    e_popular = []
    cargos.each do |c|
      query = @partido.eleccion_populars.where(cargo: c)
      if query.count == 0
        @sin_datos = true
      else
        tmp = []
        query.each do |q|
          procedimiento = []
          q.procedimientos.each do |p|
            procedimiento << {"descripcion" => p.descripcion}
          end
          requisito = []
          q.requisitos.each do |r|
            requisito << {"descripcion" => r.descripcion}
          end
          tmp <<  {"fecha_eleccion" => q.fecha_eleccion, "dias" => q.dias, "procedimientos" => procedimiento, "requisitos" => requisito}
        end
        e_popular << { "type" => c, "dates" => tmp }
        @sin_datos = true
      end
    @e_popular = e_popular
  end
end

  def organos_internos
    @organos = @partido.organo_internos
  end

  def elecciones_internas
    @elecciones = []
    organos = @partido.organo_internos
    if organos.nil?
      if_data = organos.first.eleccion_interna
      if if_data.count == 0
        @sin_datos = true
      else
        organos.each do |o|
          elecciones = o.eleccion_interna
          tmp_elecciones = []
          elecciones.each do |e|
            tmp_procedimientos = []
            e.procedimientos.each do |p|
              tmp_procedimientos << {"descripcion" => p.descripcion}
            end
            tmp_requisitos = []
            e.requisitos.each do |r|
              tmp_requisitos << {"descripcion" => r.descripcion}
            end
            tmp_elecciones << {"cargo" => e.cargo, "fecha_eleccion" => e.fecha_eleccion, "fecha_limite_inscripcion" => e.fecha_limite_inscripcion, "procedimientos" => tmp_procedimientos, "requisitos" => tmp_requisitos}
          end
          @elecciones << {"organo" => o.nombre, "elecciones_internas" => tmp_elecciones}
        end
        @sin_datos = false
      end
    else
      @sin_datos = true
    end
  end

  def representantes
    @representantes = []
    t_cargos = @partido.tipo_cargos.where(representante: true)
    if t_cargos.count == 0
      @sin_datos = true
    else
      by_gender = []
      t_cargos.each do |tc|
        filter_by = @partido.cargos.where(:tipo_cargo_id => tc.id)
        if !params[:q].blank?
          n = params[:q].split(" ")[0]
          a = params[:q].split(" ")[1] || params[:q].split(" ")[0]
          personas = Persona.where("lower(personas.nombre) like ? OR lower(personas.apellidos) like ?", n.downcase, a.downcase)
          filter_by = filter_by.where(:persona_id => personas)
        end
        if !params[:genero].blank?
          by_gender = @partido.personas.where(:genero => params[:genero])
          filter_by = filter_by.where(:persona_id => by_gender)
        end
        if !params[:region].blank?
          filter_by = filter_by.where(:region_id => params[:region])
        end
        @representantes << {"type" => tc.titulo, "representatives" => filter_by}
      end
      @sin_datos = false
    end
  end

  def acuerdos_organos
    @acuerdos = []
    acuerdo = @partido.acuerdos.where(tipo: t)
    if acuerdo.count == 0
      @sin_datos = true
    else
      tipos = %w(Acta Programatico Electoral Funcionamiento\ Interno)
      tipos.each do |t|
        acuerdos = []
        @partido.acuerdos.where(tipo: t).each do |a|
          ##puts a.region.to_i
          region = a.region.to_i == 0 ? "" : Region.find(a.region.to_i).nombre
          organo_interno  = a.organo_interno.nil? ? "" :  a.organo_interno.nombre
          documento_file_name = a.documento_file_name.nil? ? "" : a.documento_file_name
          documento_url = a.documento.url.nil? ? "" : a.documento.url
          acuerdos << {"numero" => a.numero, "tema" => a.tema, "fecha" => a.fecha, "region" => region, "organo_interno" => organo_interno, "documento" => documento_file_name, "documento_url" => documento_url}
          @acuerdos << { "type" => t, "agreements" => acuerdos }
        end
      end
      @sin_datos = false
    end
  end

  def estructura_organica

    temp_trimestres_informados = []
    @partido.organo_internos.each do |o|
      o.trimestre_informados.each do |t|

        temp_trimestres_informados.push(t)

      end
    end

    @trimestres_informados = temp_trimestres_informados.uniq.sort_by {|t| t.ano.to_s + t.ordinal.to_s}
    @trimestres_informados.reverse!

    if @trimestres_informados.count == 0
      @trimestres_informados = []
      @organos_internos = []
      @datos = []
      @sin_datos = true
    else
      params[:trimestre_informado_id] = @trimestres_informados.first.id if params[:trimestre_informado_id].nil?
      @trimestre_informado = TrimestreInformado.find(params[:trimestre_informado_id])
      @organos_internos = @trimestre_informado.organo_internos.where(:partido_id => @partido.id).page(params[:page]).per(3)
      @datos = []


      @organos_internos.each_with_index do |o, i|
        members = []
        data = @trimestre_informado.cargos.where(partido: @partido, organo_interno: o)
        if !params[:region].blank?
          data = data.where(region_id: params[:region])
        end

        if !params[:genero].blank?
          by_gender = @partido.personas.where(:genero => params[:genero])
          data = data.where(persona_id: by_gender)
        end

        data.each do |m|
          if !params[:q].blank?
            n = params[:q].split(" ")[0]
            a = params[:q].split(" ")[1] || params[:q].split(" ")[0]
            if m.persona.nombre.downcase.include?(n.downcase) || m.persona.apellidos.downcase.include?(a.downcase)
              members << {:cargo => m, :persona => m.persona, :tipo_cargo => m.tipo_cargo}
            end
          else
            members << {:cargo => m, :persona => m.persona, :tipo_cargo => m.tipo_cargo}
          end

        end
        @datos << {:organo_interno => o, :miembros => members}
      end
      @sin_datos = false
    end
    # @organos_internos = OrganoInterno.page(params[:page]).per(10)
    # @miembros = Persona.page(params[:page]).per(10)
  end

  def actividades_publicas
  end

  def intereses_patrimonios
    @intereses_patrimonios = []
    tc_candidatos = @partido.tipo_cargos.where(candidato:true)
    if tc_candidatos.count == 0
      @sin_datos = true
    else
      tc_candidatos.each do |tc|
        filter_by = @partido.cargos.where(tipo_cargo_id:tc)
        if !params[:q].blank?
          n = params[:q].split(" ")[0]
          a = params[:q].split(" ")[1] || params[:q].split(" ")[0]
          personas = Persona.where("lower(personas.nombre) like ? OR lower(personas.apellidos) like ?", n.downcase, a.downcase)
          filter_by = filter_by.where(:persona_id => personas)
        end
        if !params[:region].blank?
          filter_by = filter_by.where(:region_id => params["region"])
        end
        if !params[:genero].blank?
          by_gender = @partido.personas.where(:genero => params[:genero])
          filter_by = filter_by.where(:persona_id => by_gender)
        end
        @intereses_patrimonios << {"type" => tc.titulo, "cargos" => filter_by} unless filter_by.empty?
      end
      @sin_datos = false
    end
  end

  def publicacion_candidatos

    temp_trimestres_informados = []
    @partido.candidatos.each do |c|
      c.trimestre_informados.each do |t|

        temp_trimestres_informados.push(t)

      end
    end

    @trimestres_informados = temp_trimestres_informados.uniq.sort_by {|t| t.ano.to_s + t.ordinal.to_s}
    @trimestres_informados.reverse!

    if @trimestres_informados.count == 0
      @trimestres_informados = []
      @publicacion_candidatos = []
      @sin_datos = true
    else
      params[:trimestre_informado_id] = @trimestres_informados.first.id if params[:trimestre_informado_id].nil?
      @trimestre_informado = TrimestreInformado.find(params[:trimestre_informado_id])

      @publicacion_candidatos = []
      tc_candidatos = @partido.tipo_cargos.where(candidato:true)
      tc_candidatos.each do |tc|
        filter_by = @trimestre_informado.cargos.where(tipo_cargo_id:tc)
        if !params[:q].blank?
          n = params[:q].split(" ")[0]
          a = params[:q].split(" ")[1] || params[:q].split(" ")[0]
          personas = Persona.where("lower(personas.nombre) like ? OR lower(personas.apellidos) like ?", n.downcase, a.downcase)
          filter_by = filter_by.where(:persona_id => personas)
        end
        if !params[:region].blank?
          filter_by = filter_by.where(:region_id => params["region"])
        end
        if !params[:genero].blank?
          by_gender = @partido.personas.where(:genero => params[:genero])
          filter_by = filter_by.where(:persona_id => by_gender)
        end
        @publicacion_candidatos << {"type" => tc.titulo, "cargos" => filter_by}
      end
      @sin_datos = false
    end
  end

  def resultado_elecciones_internas
  end

  private
    def authenticate_superadmin
      ##puts "validating superadmin capabilities"
      unless current_admin.is_superadmin?
        redirect_to admin_path
      end
    end

    def max_value_transferencias_fondos_publicos(trimestre, mes, transferencia, max_value)
      if trimestre.ordinal == 0
        if (mes.include?("Enero") || mes.include?("Febrero") || mes.include?("Marzo"))
          max_value += transferencia.sum unless mes.nil?
        end

      elsif trimestre.ordinal == 1
        if (mes.include?("Abril") || mes.include?("Mayo") || mes.include?("Junio"))
          max_value += transferencia.sum
          max_value = max_value * -1 unless max_value >= 0
        end

      elsif trimestre.ordinal == 2
        if (mes.include?("Julio") || mes.include?("Agosto") || mes.include?("Septiembre"))
          max_value += transferencia.sum
          max_value = max_value * -1 unless max_value >= 0
      end

    elsif trimestre.ordinal == 3
        if (mes.include?("Octubre") || mes.include?("Noviembre") || mes.include?("Diciembre"))
          max_value += transferencia.sum
          max_value = max_value * -1 unless max_value >= 0
        end
      end
      max_value
    end

    def max_value_contrataciones_20utm(trimestre, mes, contratacion, max_value)
      if trimestre.ordinal == 0
        if (mes.include?("Enero") || mes.include?("Febrero") || mes.include?("Marzo"))
          max_value += contratacion.sum unless mes.nil?
        end

      elsif trimestre.ordinal == 1
        if (mes.include?("Abril") || mes.include?("Mayo") || mes.include?("Junio"))
          max_value += contratacion.sum
          max_value = max_value * -1 unless max_value >= 0
        end

      elsif trimestre.ordinal == 2
        if (mes.include?("Julio") || mes.include?("Agosto") || mes.include?("Septiembre"))
          max_value += contratacion.sum
          max_value = max_value * -1 unless max_value >= 0
      end

    elsif trimestre.ordinal == 3
        if (mes.include?("Octubre") || mes.include?("Noviembre") || mes.include?("Diciembre"))
          max_value += contratacion.sum
          max_value = max_value * -1 unless max_value >= 0
        end
      end
      max_value
    end

    def gasto_por_trimeste(trimestre, gasto)
      if trimestre.ordinal == 0
        gastos = (gasto.sum(:enero) + gasto.sum(:febrero) + gasto.sum(:marzo)) rescue 0
      elsif trimestre.ordinal == 1
        gastos = (gasto.sum(:abril) + gasto.sum(:mayo) + gasto.sum(:junio)) rescue 0
      elsif trimestre.ordinal == 2
        gastos = (gasto.sum(:julio) + gasto.sum(:agosto) + gasto.sum(:septiembre)) rescue 0
      elsif trimestre.ordinal == 3
        gastos = (gasto.sum(:octubre) + gasto.sum(:noviembre) + gasto.sum(:diciembre)) rescue 0
      end
      gastos
    end

    def val_egresos_ordinarios(trimestre, egreso_ordinario, max_value)
      if trimestre.ordinal == 0
        val = (((egreso_ordinario.enero.to_f + egreso_ordinario.febrero.to_f + egreso_ordinario.marzo.to_f) / max_value.to_f).to_f rescue 0).to_s
      elsif trimestre.ordinal == 1
        val = (((egreso_ordinario.abril.to_f + egreso_ordinario.mayo.to_f + egreso_ordinario.junio.to_f) / max_value.to_f).to_f rescue 0).to_s
      elsif trimestre.ordinal == 2
        val = (((egreso_ordinario.julio.to_f + egreso_ordinario.agosto.to_f + egreso_ordinario.septiembre.to_f) / max_value.to_f).to_f rescue 0).to_s
      elsif trimestre.ordinal == 3
        val = (((egreso_ordinario.octubre.to_f + egreso_ordinario.noviembre.to_f + egreso_ordinario.diciembre.to_f) / max_value.to_f).to_f rescue 0).to_s
      end
    end

    def line_egresos_ordinarios(trimestre, egreso_ordinario, val)
      if trimestre.ordinal == 0
        line = {'text' => egreso_ordinario.concepto,
                'value' => ActiveSupport::NumberHelper::number_to_delimited((egreso_ordinario.enero + egreso_ordinario.febrero + egreso_ordinario.marzo), delimiter: ""),
                'percentage' => val }
        @datos_egresos_ordinarios << line unless (egreso_ordinario.enero + egreso_ordinario.febrero + egreso_ordinario.marzo) == 0
      elsif trimestre.ordinal == 1
        line = {'text' => egreso_ordinario.concepto,
                'value' => ActiveSupport::NumberHelper::number_to_delimited((egreso_ordinario.abril + egreso_ordinario.mayo + egreso_ordinario.junio), delimiter: ""),
                'percentage' => val }
        @datos_egresos_ordinarios << line unless (egreso_ordinario.abril + egreso_ordinario.mayo + egreso_ordinario.junio) == 0
      elsif trimestre.ordinal == 2
        line = {'text' => egreso_ordinario.concepto,
                'value' => ActiveSupport::NumberHelper::number_to_delimited((egreso_ordinario.julio + egreso_ordinario.agosto + egreso_ordinario.septiembre), delimiter: ""),
                'percentage' => val }
        @datos_egresos_ordinarios << line unless (egreso_ordinario.julio + egreso_ordinario.agosto + egreso_ordinario.septiembre) == 0
      elsif trimestre.ordinal == 3
        line = {'text' => egreso_ordinario.concepto,
                'value' => ActiveSupport::NumberHelper::number_to_delimited((egreso_ordinario.octubre + egreso_ordinario.noviembre + egreso_ordinario.diciembre), delimiter: ""),
                'percentage' => val }
        @datos_egresos_ordinarios << line unless (egreso_ordinario.octubre + egreso_ordinario.noviembre + egreso_ordinario.diciembre) == 0
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_partido
      partido_id = params[:id] || params[:partido_id]
      @partido = Partido.find(partido_id)
    end

    def set_menu
      ###puts params
        @menu = params[:menu].nil? ? 0 : params[:menu].to_i

    end

    def set_fecha_datos
      ###puts params
        @fecha_datos = l(EtlRun.max_fecha_datos, format: '%A %d de %B del %Y')
        p @fecha_datos
    end

    def get_partidos
      partidos = Partido.all
      @partidos = []
      partidos.each do |p|
        @partidos << { "nombre" => p.nombre, "id" => p.id }
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def partido_params
      # params.fetch(:partido, {:nombre, :sigla, :lema})
      params.require(:partido).permit(:nombre, :sigla, :lema, :fecha_fundacion, :texto, :logo)
    end

end
