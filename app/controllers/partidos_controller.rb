class PartidosController < ApplicationController
  before_action :set_partido, only: [:show, :edit, :update, :destroy]

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

        Admin.all.each do |admin|
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
      afiliados.each do |a|
        h = h + a.hombres
        m = m + a.mujeres
      end
      region = { 'region' => r.nombre, 'hombres' => h, 'mujeres' => m }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_partido
      @partido = Partido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def partido_params
      # params.fetch(:partido, {:nombre, :sigla, :lema})
      params.require(:partido).permit(:nombre, :sigla, :lema, :fecha_fundacion, :texto, :logo)
    end
end
