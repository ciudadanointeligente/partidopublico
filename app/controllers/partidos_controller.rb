class PartidosController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_partido, except: [:index, :new, :create, :admin]
  layout "frontend", only: [:normas_internas, :regiones, :sedes, :autoridades, :vinculos_intereses, :pactos, :sanciones]

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
    @datos_region = []
    @datos_nacional = []
    @rangos_edad = []
    nh = 0
    nm = 0
    pnh = 0
    pnm = 0
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
      nh = nh + h
      nm = nm + m
      total_n = nh+nm
      pnh = (nh*100)/total_n
      pnm = (nm*100)/total_n

      region = { 'region' => r.nombre, 'ordinal' => r.ordinal, 'hombres' => h, 'porcentaje_hombres' => ph, 'mujeres' => m, 'porcentaje_mujeres' => pm }
      @datos_region.push region
    end
    nacional = { 'hombres' => nh, 'mujeres' => nm, 'porcentaje_nac_hombres' => pnh, 'porcentaje_nac_mujeres' => pnm, 'total' => nh + nm }
    @datos_nacional.push nacional

    rangos = [[14,17],[18,24],[25,29],[30,34],[35,39],[40,44],[45,49],[50,54],[55,59],[60,64],[65,69],[70,13]]
    rangos.each do |r|
      @partido.afiliacions.where :ano_nacimiento => r[0]..r[1]
    end
  end

  def sedes
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
