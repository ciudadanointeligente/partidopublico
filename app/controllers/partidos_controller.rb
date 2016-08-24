class PartidosController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_partido, except: [:index, :new, :create, :admin]
  layout "frontend", only: [:normas_internas, :regiones, :sedes_partido, :autoridades,
                            :vinculos_intereses, :pactos, :sanciones, :finanzas_1, :finanzas_2,
                            :afiliacion_desafiliacion, :eleccion_popular, :organos_internos, :elecciones_internas]


  # GET /partidos
  # GET /partidos.json
  def index
    @partidos = Partido.all
  end

  def admin
    if admin_signed_in?
      @partidos = current_admin.partidos
      if current_admin.is_superadmin?
        @login_data = []

        Admin.order(last_sign_in_at: :desc).each do |admin|
          admin_logins = AdminLogin.where admin: admin
          logins = []
          admin_logins.order(fecha: :desc).limit(3).each do |login|
            logins << {fecha: login.fecha, ip: login.ip}
          end
          @login_data << {email: admin.email, login_count: admin_logins.count, logins: logins}
        end
        puts @login_data
      end
    else
      redirect_to new_admin_session_path
    end
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
    @partido.destroy
    respond_to do |format|
      format.html { redirect_to partidos_url, notice: 'Partido was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def normas_internas
    @normas_internas = []
    @partido.marco_interno.documentos.each do |d|
      if !d.archivo_file_name.nil?
        @normas_internas.push d
      end
    end
  end

  def regiones
    rangos = [[14,17],[18,24],[25,29],[30,34],[35,39],[40,44],[45,49],[50,54],[55,59],[60,64],[65,69],[70,100]]
    @datos_region = []
    @datos_nacional = []
    @rangos_edad = []

    nh = 0 #nacional hombres
    nm = 0 #nacional mujeres
    pnh = 0 #promedio nacional hombres
    pnm = 0 #promedio nacional mujeres

    nacional = { "region" => "nacional", "ordinal" => "nacional", "hombres" => 0, "mujeres" => 0, "porcentaje_hombres" => 0, "porcentaje_mujeres" => 0, "total" => 0, "desgloce" => [] }

    last_date = Afiliacion.where(partido_id: @partido).uniq.pluck(:fecha_datos).sort.last

    @partido.regions.each do |r|
      afiliados = Afiliacion.where(partido_id: @partido, region_id: r, fecha_datos: last_date)
      if afiliados.any?
        h = 0 #hombres
        m = 0 #mujeres
        ph = 0 #promedio hombres
        pm = 0 #promedio mujeres
        afiliados.each do |a|
          h = h + a.hombres
          m = m + a.mujeres
          total = h+m
          ph = (h*100)/total
          pm = (m*100)/total
        end
        nh = nh + h #nacional hombres
        nm = nm + m #nacional mujeres
        total_n = nh+nm #total nacional
        pnh = (nh*100)/total_n #promedio nacional hombres
        pnm = (nm*100)/total_n #promedio nacional mujeres

        region = { "region" => r.nombre, "ordinal" => r.ordinal, "hombres" => h, "porcentaje_hombres" => ph, "mujeres" => m, "porcentaje_mujeres" => pm, "total" => h + m, "desgloce" => [] }

        participantes = 0
        rangos.each do |rango|
          participantes = @partido.afiliacions.where(:ano_nacimiento => Date.today.year-rango[1]..Date.today.year-rango[0], :region_id => r, fecha_datos: last_date)
          ph = 0 #participantes hombres
          pm = 0 #participantes mujeres
          participantes.each do |np|
            ph = ph + np.hombres
            pm = pm + np.mujeres
          end
          region["desgloce"].push({ rango[0].to_s+'-'+rango[1].to_s => ph + pm })
        end
        @datos_region.push region
      end

    end

    nacional = { "region" => "nacional", "ordinal" => "nacional", "hombres" => nh, "mujeres" => nm, "porcentaje_hombres" => pnh, "porcentaje_mujeres" => pnm, "total" => nh + nm, "desgloce" => [] }
    a = []
    if @datos_region.any?
      puts '++++++++++++++++'
      p @datos_region
      @datos_region.each do |dr|
        dr["desgloce"].each do |d|
          a << d
        end
      end
      nacional["desgloce"] << a.inject{ |x,y| x.merge(y) { |k,old_v, new_v| old_v+new_v } }
    end


    @datos_nacional.push nacional

    @datos_total_nacional = @datos_nacional + @datos_region
  end

  def sedes_partido
    @datos_sedes = []
    @partido.regions.each do |r|
      sedes = @partido.sedes.where(region_id: r)
      all_sedes = []
      sedes.each do |s|
        all_sedes.push( { 'direccion' => s.direccion, 'contacto' => s.contacto, 'comuna' => s.comuna.nombre } )
      end
      @datos_sedes.push( {'region' => r.nombre, 'sedes' => all_sedes} )
    end
  end

  def autoridades
    @datos_cargos = []
    @partido.regions.each do |r|
      cargos = @partido.cargos.where(region_id: r)
      all_cargos = []
      cargos.each do |c|
        all_cargos.push( { 'persona' => c.persona.nombre, 'cargo' => c.tipo_cargo.titulo, 'comuna' => c.comuna.nombre } )
      end
      @datos_cargos.push( {'region' => r.nombre, 'cargos' => all_cargos} )
    end
  end

  def vinculos_intereses
    @entidades = []
    @partido.participacion_entidads.each do |p|
      @entidades.push p
    end
  end

  def pactos
    @pactos = []
    @partido.pacto_electorals.each do |p|
      @pactos.push p
    end
  end

  def sanciones
    @sanciones = []
    @partido.sancions.each do |s|
      @sanciones.push s
    end
  end

  def finanzas_1
    @fechas_datos = IngresoOrdinario.where(partido: @partido).uniq.pluck(:fecha_datos).sort
    if params[:fecha_datos]
      @fecha = Date.new(params[:fecha_datos].split("-")[0].to_i, params[:fecha_datos].split("-")[1].to_i, params[:fecha_datos].split("-")[2].to_i)
    else
      @fecha = @fechas_datos.last
    end
    ingresos_ordinarios = IngresoOrdinario.where(:partido => @partido, :fecha_datos => @fecha )
    max_value = ingresos_ordinarios.maximum(:importe)
    @datos_ingresos_ordinarios = []
    ingresos_ordinarios.each do |io|
      val = (100 * (io.importe.to_f / max_value.to_f).to_f rescue 0).to_s
      line ={ 'text'=> io.concepto, 'value' => ActiveSupport::NumberHelper::number_to_delimited(io.importe, delimiter: "."), 'percentage' => val }
      @datos_ingresos_ordinarios << line
    end
    total_publicos = ingresos_ordinarios.where(:concepto => "Aportes Estatales").first.importe rescue 0
    total_privados = ingresos_ordinarios.sum(:importe) - total_publicos
    @datos_ingresos_ordinarios_totals = { 'publicos'=> total_publicos, 'privados' => total_privados}
  end

  def finanzas_2
    @fechas_datos = EgresoOrdinario.where(partido: @partido).uniq.pluck(:fecha_datos).sort
    if params[:fecha_datos]
      @fecha = Date.new(params[:fecha_datos].split("-")[0].to_i, params[:fecha_datos].split("-")[1].to_i, params[:fecha_datos].split("-")[2].to_i)
    else
      @fecha = @fechas_datos.last
    end
    egresos_ordinarios = EgresoOrdinario.where(:partido => @partido, :fecha_datos => @fecha )
    max_value = egresos_ordinarios.maximum("privado + publico")
    @datos_egresos_ordinarios = []
    egresos_ordinarios.each do |eo|
      val = (100 * ((eo.publico.to_f + eo.privado.to_f)/ max_value.to_f).to_f rescue 0).to_s
      line ={ 'text'=> eo.concepto, 'value_publico' => eo.publico, 'value_privado' => eo.privado,
        'value' => ActiveSupport::NumberHelper::number_to_delimited(eo.privado + eo.publico, delimiter: "."), 'percentage' => val }
      @datos_egresos_ordinarios << line
    end
    total_publicos = egresos_ordinarios.sum(:publico)
    total_privados = egresos_ordinarios.sum(:privado)
    @datos_egresos_ordinarios_totals = { 'publicos'=> total_publicos, 'privados' => total_privados}
  end

  def afiliacion_desafiliacion
    @tramites = @partido.tramites
  end

  def eleccion_popular

    cargos = %w(Presidente Senador Diputado Consejero\ Regional Alcalde Concejal)
    e_popular = []
    cargos.each do |c|
      query = @partido.eleccion_populars.where(cargo: c)
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
    end

    @e_popular = e_popular
  end

  def organos_internos
    @organos = @partido.organo_internos
  end

  def elecciones_internas
    @elecciones = []
    organos = @partido.organo_internos
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
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partido
      partido_id = params[:id] || params[:partido_id]
      @partido = Partido.find(partido_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def partido_params
      # params.fetch(:partido, {:nombre, :sigla, :lema})
      params.require(:partido).permit(:nombre, :sigla, :lema, :fecha_fundacion, :texto, :logo)
    end
end
