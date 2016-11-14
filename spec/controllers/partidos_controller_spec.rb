require 'rails_helper'

RSpec.describe PartidosController, type: :controller do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:valid_session) { {} }

  describe "GET #normas_internas" do
    it "get an array of normas internas" do
      partido = create(:partido)
      new_document = create(:documento)
      partido.marco_interno.documentos << new_document
      normas_internas = []
      partido.marco_interno.documentos.each do |d|
        if !d.archivo_file_name.nil?
          normas_internas.push d
        end
      end

      get :normas_internas, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:normas_internas)).to eq(normas_internas)
    end
  end

  describe "GET #regiones" do
    it "get an array of presencia nacional" do
      partido = create(:partido)

      region_1 = create(:region, :nombre => "Region 1", :ordinal => "I")
      region_2 = create(:region, :nombre => "Region 2", :ordinal => "II")
      region_3 = create(:region, :nombre => "Region 3", :ordinal => "III")

      partido.regions << [region_1, region_2, region_3]

      persona_1 = create(:persona, :rut => '1-1', :partido_id => partido.id)
      persona_2 = create(:persona, :rut => '1-2', :partido_id => partido.id)
      persona_3 = create(:persona, :rut => '1-3', :partido_id => partido.id)
      persona_4 = create(:persona, :rut => '1-4', :partido_id => partido.id)
      persona_5 = create(:persona, :rut => '1-5', :partido_id => partido.id)
      persona_6 = create(:persona, :rut => '1-6', :partido_id => partido.id)
      persona_7 = create(:persona, :rut => '1-7', :partido_id => partido.id)
      persona_8 = create(:persona, :rut => '1-8', :partido_id => partido.id)
      persona_9 = create(:persona, :rut => '1-9', :partido_id => partido.id)

      afiliacion_region_1 = create(:afiliacion, :hombres => 15, :mujeres => 20, :partido_id => partido.id, :region_id => region_1.id, :fecha_datos => '2016-01-01', :ano_nacimiento => 1981)
      afiliacion_region_2 = create(:afiliacion, :hombres => 25, :mujeres => 10, :partido_id => partido.id, :region_id => region_2.id, :fecha_datos => '2016-01-01', :ano_nacimiento => 1981)
      afiliacion_region_3 = create(:afiliacion, :hombres => 35, :mujeres => 30, :partido_id => partido.id, :region_id => region_3.id, :fecha_datos => '2016-01-01', :ano_nacimiento => 1981)

      tipo_cargo_alcalde = create(:tipo_cargo, :titulo => "Alcalde", :representante => true, :partido_id => partido.id)

      cargo_alcalde_1_region_1 = create(:cargo, :persona_id => persona_1.id, :tipo_cargo_id => tipo_cargo_alcalde.id, :partido_id => partido.id, :region_id => region_1.id)
      cargo_alcalde_2_region_1 = create(:cargo, :persona_id => persona_8.id, :tipo_cargo_id => tipo_cargo_alcalde.id, :partido_id => partido.id, :region_id => region_1.id)
      cargo_alcalde_3_region_1 = create(:cargo, :persona_id => persona_9.id, :tipo_cargo_id => tipo_cargo_alcalde.id, :partido_id => partido.id, :region_id => region_1.id)

      cargo_alcalde_region_2 = create(:cargo, :persona_id => persona_3.id, :tipo_cargo_id => tipo_cargo_alcalde.id, :partido_id => partido.id, :region_id => region_2.id)
      cargo_alcalde_region_3 = create(:cargo, :persona_id => persona_5.id, :tipo_cargo_id => tipo_cargo_alcalde.id, :partido_id => partido.id, :region_id => region_3.id)

      get :regiones, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:datos_total_nacional)).not_to be_empty
      expect(assigns(:datos_total_nacional)[0]['hombres'].floor).to eq(afiliacion_region_1.hombres + afiliacion_region_2.hombres + afiliacion_region_3.hombres)
      expect(assigns(:datos_total_nacional)[0]['mujeres'].floor).to eq(afiliacion_region_1.mujeres + afiliacion_region_2.mujeres + afiliacion_region_3.mujeres)
    end

    it "get an array of presencia de cargos" do
      partido = create(:partido)

      region_1 = create(:region, :nombre => "Region 1", :ordinal => "I")
      region_2 = create(:region, :nombre => "Region 2", :ordinal => "II")
      region_3 = create(:region, :nombre => "Region 3", :ordinal => "III")
      region_4 = create(:region, :nombre => "Region 4", :ordinal => "IV")

      partido.regions << [region_1, region_2, region_3, region_4]

      tipo_cargo_alcalde = create(:tipo_cargo, :titulo => "Alcalde", :representante => true, :partido_id => partido.id)
      tipo_cargo_senador = create(:tipo_cargo, :titulo => "Senador", :representante => true, :partido_id => partido.id)
      tipo_cargo_secretario = create(:tipo_cargo, :titulo => "Secretario", :cargo_interno => true, :partido_id => partido.id)
      tipo_cargo_ministro = create(:tipo_cargo, :titulo => "Ministro", :autoridad => true, :partido_id => partido.id)

      persona_1 = create(:persona, :rut => '1-1', :partido_id => partido.id)
      persona_2 = create(:persona, :rut => '1-2', :partido_id => partido.id)
      persona_3 = create(:persona, :rut => '1-3', :partido_id => partido.id)
      persona_4 = create(:persona, :rut => '1-4', :partido_id => partido.id)
      persona_5 = create(:persona, :rut => '1-5', :partido_id => partido.id)
      persona_6 = create(:persona, :rut => '1-6', :partido_id => partido.id)
      persona_7 = create(:persona, :rut => '1-7', :partido_id => partido.id)
      persona_8 = create(:persona, :rut => '1-8', :partido_id => partido.id)
      persona_9 = create(:persona, :rut => '1-9', :partido_id => partido.id)

      afiliacion_region_1 = create(:afiliacion, :hombres => 15, :mujeres => 20, :partido_id => partido.id, :region_id => region_1.id, :fecha_datos => '2016-01-01', :ano_nacimiento => 1981)
      afiliacion_region_2 = create(:afiliacion, :hombres => 25, :mujeres => 10, :partido_id => partido.id, :region_id => region_2.id, :fecha_datos => '2016-01-01', :ano_nacimiento => 1981)
      afiliacion_region_3 = create(:afiliacion, :hombres => 35, :mujeres => 30, :partido_id => partido.id, :region_id => region_3.id, :fecha_datos => '2016-01-01', :ano_nacimiento => 1981)
      afiliacion_region_4 = create(:afiliacion, :hombres => 0, :mujeres => 0, :partido_id => partido.id, :region_id => region_4.id, :fecha_datos => '2016-01-01', :ano_nacimiento => 1981)

      cargo_alcalde_1_region_1 = create(:cargo, :persona_id => persona_1.id, :tipo_cargo_id => tipo_cargo_alcalde.id, :partido_id => partido.id, :region_id => region_1.id)
      cargo_alcalde_2_region_1 = create(:cargo, :persona_id => persona_8.id, :tipo_cargo_id => tipo_cargo_alcalde.id, :partido_id => partido.id, :region_id => region_1.id)
      cargo_ministro_region_1 = create(:cargo, :persona_id => persona_9.id, :tipo_cargo_id => tipo_cargo_ministro.id, :partido_id => partido.id, :region_id => region_1.id)

      cargo_alcalde_region_2 = create(:cargo, :persona_id => persona_3.id, :tipo_cargo_id => tipo_cargo_alcalde.id, :partido_id => partido.id, :region_id => region_2.id)
      cargo_alcalde_region_3 = create(:cargo, :persona_id => persona_5.id, :tipo_cargo_id => tipo_cargo_alcalde.id, :partido_id => partido.id, :region_id => region_3.id)

      cargo_senador_region_1 = create(:cargo, :persona_id => persona_2.id, :tipo_cargo_id => tipo_cargo_senador.id, :partido_id => partido.id, :region_id => region_1.id)
      cargo_senador_region_2 = create(:cargo, :persona_id => persona_4.id, :tipo_cargo_id => tipo_cargo_senador.id, :partido_id => partido.id, :region_id => region_2.id)
      cargo_senador_region_3 = create(:cargo, :persona_id => persona_6.id, :tipo_cargo_id => tipo_cargo_senador.id, :partido_id => partido.id, :region_id => region_3.id)

      cargo_secretario_partido = create(:cargo, :persona_id => persona_7.id, :tipo_cargo_id => tipo_cargo_secretario.id, :partido_id => partido.id, :region_id => region_1.id)

      get :regiones, {:partido_id => partido.to_param}, valid_session

      # nacional
      nro_autoridades = partido.cargos.where(:tipo_cargo_id => partido.tipo_cargos.where(:autoridad => true)).count
      expect(assigns(:datos_total_nacional)[0]["cargos"][0]["nro_cargos"]).to eq(nro_autoridades)

      nro_cargos_internos = partido.cargos.where(:tipo_cargo_id => partido.tipo_cargos.where(:cargo_interno => true)).count
      expect(assigns(:datos_total_nacional)[0]["cargos"][1]["nro_cargos"]).to eq(nro_cargos_internos)

      nro_representantes = partido.cargos.where(:tipo_cargo_id => partido.tipo_cargos.where(:representante => true)).count
      expect(assigns(:datos_total_nacional)[0]["cargos"][2]["nro_cargos"]).to eq(nro_representantes)

      #regional
      nro_autoridades = partido.cargos.where(:region_id => region_1.id, :tipo_cargo_id => partido.tipo_cargos.where(:autoridad => true)).count
      expect(assigns(:datos_total_nacional)[1]["cargos"][0]["nro_cargos"]).to eq(nro_autoridades)

      nro_cargos_internos = partido.cargos.where(:region_id => region_1.id, :tipo_cargo_id => partido.tipo_cargos.where(:cargo_interno => true)).count
      expect(assigns(:datos_total_nacional)[1]["cargos"][1]["nro_cargos"]).to eq(nro_cargos_internos)

      nro_representantes = partido.cargos.where(:region_id => region_1.id, :tipo_cargo_id => partido.tipo_cargos.where(:representante => true)).count
      expect(assigns(:datos_total_nacional)[1]["cargos"][2]["nro_cargos"]).to eq(nro_representantes)

    end

    it "get an array of presencia de cargos without cargos" do
      partido = create(:partido)

      region_1 = create(:region, :nombre => "Region 1", :ordinal => "I")
      region_2 = create(:region, :nombre => "Region 2", :ordinal => "II")
      region_3 = create(:region, :nombre => "Region 3", :ordinal => "III")

      partido.regions << [region_1, region_2, region_3]

      afiliacion_region_1 = create(:afiliacion, :hombres => 15, :mujeres => 20, :partido_id => partido.id, :region_id => region_1.id, :fecha_datos => '2016-01-01', :ano_nacimiento => 1981)
      afiliacion_region_2 = create(:afiliacion, :hombres => 25, :mujeres => 10, :partido_id => partido.id, :region_id => region_2.id, :fecha_datos => '2016-01-01', :ano_nacimiento => 1981)
      afiliacion_region_3 = create(:afiliacion, :hombres => 35, :mujeres => 30, :partido_id => partido.id, :region_id => region_3.id, :fecha_datos => '2016-01-01', :ano_nacimiento => 1981)

      get :regiones, {:partido_id => partido.to_param}, valid_session

      # puts '-+-+-+-+-+--+-+-+-+-'
      # p assigns(:datos_total_nacional)
      # puts '-+-+-+-+-+--+-+-+-+-'

      # nacional
      nro_autoridades = partido.cargos.where(:tipo_cargo_id => partido.tipo_cargos.where(:autoridad => true)).count
      expect(assigns(:datos_total_nacional)[0]["cargos"][0]["nro_cargos"]).to eq(nro_autoridades)

      nro_cargos_internos = partido.cargos.where(:tipo_cargo_id => partido.tipo_cargos.where(:cargo_interno => true)).count
      expect(assigns(:datos_total_nacional)[0]["cargos"][1]["nro_cargos"]).to eq(nro_cargos_internos)

      nro_representantes = partido.cargos.where(:tipo_cargo_id => partido.tipo_cargos.where(:representante => true)).count
      expect(assigns(:datos_total_nacional)[0]["cargos"][2]["nro_cargos"]).to eq(nro_representantes)

      #regional
      nro_autoridades = partido.cargos.where(:region_id => region_1.id, :tipo_cargo_id => partido.tipo_cargos.where(:autoridad => true)).count
      expect(assigns(:datos_total_nacional)[1]["cargos"][0]["nro_cargos"]).to eq(nro_autoridades)

      nro_cargos_internos = partido.cargos.where(:region_id => region_1.id, :tipo_cargo_id => partido.tipo_cargos.where(:cargo_interno => true)).count
      expect(assigns(:datos_total_nacional)[1]["cargos"][1]["nro_cargos"]).to eq(nro_cargos_internos)

      nro_representantes = partido.cargos.where(:region_id => region_1.id, :tipo_cargo_id => partido.tipo_cargos.where(:representante => true)).count
      expect(assigns(:datos_total_nacional)[1]["cargos"][2]["nro_cargos"]).to eq(nro_representantes)
    end
  end

  describe "GET #sedes_partido" do
    it "get an array of sedes by regions from a party" do
      partido = create(:partido)
      region = create(:region)
      comuna = create(:comuna)
      sede_1 = create(:sede, :region_id => region.id, :comuna_id => comuna.id)
      partido.sedes << sede_1
      partido.regions << region

      sedes = [{'region' => region.nombre, 'sedes' => [{ 'direccion' => sede_1.direccion, 'contacto' => sede_1.contacto, 'comuna' => sede_1.comuna.nombre }]}]

      get :sedes_partido, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:datos_sedes)).to eq(sedes)
    end
  end

  describe "GET #autoridades" do
    it "return an array with all autorities" do
      partido = create(:partido)
      region = create(:region)
      comuna = create(:comuna)
      partido.regions << region

      ministro = create(:tipo_cargo, titulo: "Ministro", :autoridad => true, partido_id: partido.id)
      subsecretario = create(:tipo_cargo, titulo: "Subsecretario", :autoridad => true, partido_id: partido.id)

      persona_1 = create(:persona, :partido_id => partido.id, rut: "1-2", genero: "Masculino")
      persona_2 = create(:persona, :partido_id => partido.id, rut: "1-3", genero: "Femenino")
      persona_3 = create(:persona, :partido_id => partido.id, rut: "1-4", genero: "Femenino")

      cargo_ministro = create(:cargo, :partido_id => partido.id, :region_id => region.id, :comuna_id => comuna.id, :persona_id => persona_2.id, :tipo_cargo_id => ministro.id)
      cargo_subsecretario_1 = create(:cargo, :partido_id => partido.id, :region_id => region.id, :comuna_id => comuna.id, :persona_id => persona_1.id, :tipo_cargo_id => subsecretario.id)
      cargo_subsecretario_2 = create(:cargo, :partido_id => partido.id, :region_id => region.id, :comuna_id => comuna.id, :persona_id => persona_2.id, :tipo_cargo_id => subsecretario.id)

      get :autoridades, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:autoridades).count).to eq(partido.tipo_cargos.where(autoridad: true).count)
      expect(assigns(:autoridades)[0]["cargos"]).to include(cargo_ministro)
      expect(assigns(:autoridades)[1]["cargos"]).to include(cargo_subsecretario_1, cargo_subsecretario_2)
    end

    it "return by region" do
      partido = create(:partido)
      region_1 = create(:region)
      region_2 = create(:region)
      comuna = create(:comuna)
      partido.regions << [region_1, region_2]

      ministro = create(:tipo_cargo, titulo: "Ministro", :autoridad => true, partido_id: partido.id)
      subsecretario = create(:tipo_cargo, titulo: "Subsecretario", :autoridad => true, partido_id: partido.id)

      persona_1 = create(:persona, :partido_id => partido.id, rut: "1-2", genero: "Masculino")
      persona_2 = create(:persona, :partido_id => partido.id, rut: "1-3", genero: "Femenino")
      persona_3 = create(:persona, :partido_id => partido.id, rut: "1-4", genero: "Femenino")

      cargo_ministro = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna.id, :persona_id => persona_2.id, :tipo_cargo_id => ministro.id)
      cargo_subsecretario_1 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna.id, :persona_id => persona_1.id, :tipo_cargo_id => subsecretario.id)
      cargo_subsecretario_2 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna.id, :persona_id => persona_2.id, :tipo_cargo_id => subsecretario.id)

      get :autoridades, {:partido_id => partido.to_param, region: region_1.id}, valid_session

      expect(assigns(:autoridades)[0]["cargos"]).to include(cargo_ministro)
      expect(assigns(:autoridades)[1]["cargos"]).to_not include(cargo_subsecretario_2)
    end

    it "return by gender" do
      partido = create(:partido)
      region_1 = create(:region)
      region_2 = create(:region)
      comuna = create(:comuna)
      partido.regions << [region_1, region_2]

      ministro = create(:tipo_cargo, titulo: "Ministro", :autoridad => true, partido_id: partido.id)
      subsecretario = create(:tipo_cargo, titulo: "Subsecretario", :autoridad => true, partido_id: partido.id)

      persona_1 = create(:persona, :partido_id => partido.id, rut: "1-2", genero: "Masculino")
      persona_2 = create(:persona, :partido_id => partido.id, rut: "1-3", genero: "Femenino")
      persona_3 = create(:persona, :partido_id => partido.id, rut: "1-4", genero: "Femenino")

      cargo_ministro = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna.id, :persona_id => persona_2.id, :tipo_cargo_id => ministro.id)
      cargo_subsecretario_1 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna.id, :persona_id => persona_1.id, :tipo_cargo_id => subsecretario.id)
      cargo_subsecretario_2 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna.id, :persona_id => persona_2.id, :tipo_cargo_id => subsecretario.id)

      get :autoridades, {:partido_id => partido.to_param, genero: "Femenino"}, valid_session

      expect(assigns(:autoridades)[0]["cargos"]).to include(cargo_ministro)
      expect(assigns(:autoridades)[1]["cargos"]).to_not include(cargo_subsecretario_1)
      expect(assigns(:autoridades)[1]["cargos"]).to include(cargo_subsecretario_2)
    end

    it "return by input search" do
      partido = create(:partido)
      region_1 = create(:region)
      region_2 = create(:region)
      comuna = create(:comuna)
      partido.regions << [region_1, region_2]

      ministro = create(:tipo_cargo, titulo: "Ministro", :autoridad => true, partido_id: partido.id)
      subsecretario = create(:tipo_cargo, titulo: "Subsecretario", :autoridad => true, partido_id: partido.id)

      persona_1 = create(:persona, nombre: "Juan", apellidos: "Gonzáles", :partido_id => partido.id, rut: "1-2", genero: "Masculino")
      persona_2 = create(:persona, nombre: "Juana", apellidos: "de la Maza", :partido_id => partido.id, rut: "1-3", genero: "Femenino")
      persona_3 = create(:persona, nombre: "Jean", apellidos: "Gonzales", :partido_id => partido.id, rut: "1-4", genero: "Femenino")

      cargo_ministro = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna.id, :persona_id => persona_2.id, :tipo_cargo_id => ministro.id)
      cargo_subsecretario_1 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna.id, :persona_id => persona_1.id, :tipo_cargo_id => subsecretario.id)
      cargo_subsecretario_2 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna.id, :persona_id => persona_2.id, :tipo_cargo_id => subsecretario.id)

      get :autoridades, {:partido_id => partido.to_param, q: "Juan"}, valid_session

      expect(assigns(:autoridades)[0]["cargos"]).to_not include(cargo_ministro)
      expect(assigns(:autoridades)[1]["cargos"]).to include(cargo_subsecretario_1)
    end
  end

  describe "GET #vinculos_intereses" do
    it "return an array of intereses" do
      partido = create(:partido)
      entidad_1 = create(:participacion_entidad, :partido_id => partido.id)

      get :vinculos_intereses, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:entidades)).to eq(partido.participacion_entidads)
    end
  end

  describe "GET #pactos" do
    it "return an array of pactos" do
      partido = create(:partido)
      partido_pacto_1 = create(:partido, :nombre => "partido 01", :sigla => 'SP01')
      partido_pacto_2 = create(:partido, :nombre => "partido 02", :sigla => 'SP02')
      pacto = create(:pacto_electoral)
      pacto.partidos << [partido_pacto_1, partido_pacto_2]
      partido.pacto_electorals << pacto

      get :pactos, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:pactos)).to eq(partido.pacto_electorals)
    end
  end

  describe "GET #sanciones" do
    it "return an array of sanciones" do
      partido = create(:partido)
      sancion_01 = create(:sancion, :partido_id => partido.id)
      sancion_02 = create(:sancion, :partido_id => partido.id)

      get :sanciones, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:sanciones)).to eq(partido.sancions)
      expect(assigns(:sanciones)).to include(sancion_01)
      expect(assigns(:sanciones)).to include(sancion_02)
    end
  end

  describe "GET #afiliacion_desafiliacion" do
    it "return an array of afiliacion/desafiliacion process" do
      partido = create(:partido)
      tramite_afiliacion = create(:tramite, :partido_id => partido.id )
      tramite_desafiliacion = create(:tramite)

      get :afiliacion_desafiliacion, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:tramites)).to eq(partido.tramites)
      expect(assigns(:tramites)).to include(tramite_afiliacion)
      expect(assigns(:tramites)).to_not include(tramite_desafiliacion)
    end
  end

  describe "GET #eleccion_popular" do
    it "return an array with eleccion popular" do
      partido = create(:partido)
      presidencia = create(:eleccion_popular, :partido_id => partido.id, :cargo => "Presidente", :fecha_eleccion => "2016-12-31", :dias => 5)
      alcaldia = create(:eleccion_popular, :partido_id => partido.id, :cargo => "Alcalde", :fecha_eleccion => "2016-12-31", :dias => 25)

      e_popular = [{"type"=>"Presidente", "dates"=> [{"fecha_eleccion"=>presidencia.fecha_eleccion, "dias"=>presidencia.dias, "procedimientos"=>[], "requisitos"=>[]}]},
                    {"type"=>"Senador", "dates"=>[]}, {"type"=>"Diputado", "dates"=>[]}, {"type"=>"Consejero Regional", "dates"=>[]},
                    {"type"=>"Alcalde", "dates"=> [{"fecha_eleccion"=>alcaldia.fecha_eleccion, "dias"=>alcaldia.dias, "procedimientos"=>[], "requisitos"=>[]}]},
                    {"type"=>"Concejal", "dates"=>[]}]

      get :eleccion_popular, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:e_popular)).to eq(e_popular)
    end
  end

  describe "GET #organos_internos" do
    it "return an array of organos_internos" do
      partido = create(:partido)
      organo_interno = create(:organo_interno, :partido_id => partido.id)

      get :organos_internos, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:organos)).to eq(partido.organo_internos)
      expect(assigns(:organos)).to include(organo_interno)
    end
  end

  describe "GET #elecciones_internas" do
    it "return an array of elecciones" do
      partido = create(:partido)
      org_interno = create(:organo_interno, :partido_id => partido.id)
      eleccion_interna = create(:eleccion_interna, :partido_id => partido.id, :organo_interno_id => org_interno.id)

      elecciones = [{"organo"=>"Órgano ejecutivo", "elecciones_internas"=>[]},
                    {"organo"=>"Órgano intermedio colegiado", "elecciones_internas"=>[]},
                    {"organo"=>"Tribunal supremo", "elecciones_internas"=>[]},
                    {"organo"=>org_interno.nombre, "elecciones_internas"=>[{"cargo"=>eleccion_interna.cargo, "fecha_eleccion"=>eleccion_interna.fecha_eleccion, "fecha_limite_inscripcion"=>eleccion_interna.fecha_limite_inscripcion, "procedimientos"=>[], "requisitos"=>[]}]}]

      get :elecciones_internas, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:elecciones)).to eq(elecciones)
    end
  end

  describe "GET #finanzas_1" do
    it "return publicos y privados" do
      partido = create(:partido)
      ingreso_1 = create(:ingreso_ordinario, :partido_id => partido.id, :fecha_datos => "2016-01-01", :concepto => "concepto 01", :importe => 1000)
      ingreso_2 = create(:ingreso_ordinario, :partido_id => partido.id, :fecha_datos => "2016-01-01", :concepto => "Aportes Estatales", :importe => 2000)

      ingresos_ordinarios = { 'publicos'=> ingreso_2.importe, 'privados' => ingreso_1.importe}

      get :finanzas_1, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:datos_ingresos_ordinarios_totals)).to eq(ingresos_ordinarios)
    end
  end

  describe "GET finanzas_2" do
    it "return finanzas_2" do
      partido = create(:partido)
      egreso_1 = create(:egreso_ordinario, :partido_id => partido.id, :fecha_datos => "2016-01-01", :privado => 1200, :publico => 800)
      egreso_2 = create(:egreso_ordinario, :partido_id => partido.id, :fecha_datos => "2016-01-01", :privado => 1300, :publico => 700)

      get :finanzas_2, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:datos_egresos_ordinarios_totals)).to eq({"publicos"=> egreso_1.publico+egreso_2.publico, "privados"=>egreso_1.privado+egreso_2.privado})
    end
  end

  describe "GET finanzas_5" do
    it "return finanzas_5" do
      partido = create(:partido)
      transferencia_1 = create(:transferencia, :partido_id => partido.id)

      get :finanzas_5, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:fecha)).to eq(transferencia_1.fecha_datos)
    end
  end

  describe "GET #acuerdos_organos" do
    it "return an array with acuerdos by tipo" do
      partido = create(:partido)
      organo_interno = create(:organo_interno, :nombre => 'Un Organo Interno')
      region_1 = create(:region)
      region_2 = create(:region)
      acuerdo_1 = create(:acuerdo, :tipo => 'Funcionamiento Interno', :organo_interno_id => organo_interno.id, :region => region_1.id.to_s)
      acuerdo_2 = create(:acuerdo, :tipo => 'Electoral', :organo_interno_id => organo_interno.id, :region => region_2.id.to_s)
      acuerdo_3 = create(:acuerdo, :tipo => 'Electoral', :organo_interno_id => organo_interno.id, :region => region_2.id.to_s)
      partido.acuerdos << [acuerdo_1, acuerdo_2, acuerdo_3]

      get :acuerdos_organos, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:acuerdos).count).to eq(4)
      expect(assigns(:acuerdos)[2]["agreements"].count).to eq(2)
    end
  end

  describe "GET #representantes" do
    it "get an array of representantes" do
      partido = create(:partido)
      region = create(:region)
      comuna_1 = create(:comuna)
      comuna_2 = create(:comuna)
      cargo_alcalde = create(:tipo_cargo, :titulo =>"Alcalde", :representante => true, partido_id: partido.id)
      cargo_senador = create(:tipo_cargo, :titulo =>"Senador", :representante => true, partido_id: partido.id)
      persona_1 = create(:persona, :rut => '1-2', :partido_id => partido.id)
      persona_2 = create(:persona, :rut => '3-4', :partido_id => partido.id)

      cargo_1 = create(:cargo, :partido_id => partido.id, :region_id => region.id, :comuna_id => comuna_1.id, :persona_id => persona_1.id, :tipo_cargo_id => cargo_alcalde.id)
      cargo_2 = create(:cargo, :partido_id => partido.id, :region_id => region.id, :comuna_id => comuna_2.id, :persona_id => persona_2.id, :tipo_cargo_id => cargo_senador.id)

      get :representantes, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:representantes)[6]['representatives'].count).to eq(1)
      expect(assigns(:representantes)[6]['representatives']).to include(cargo_1)
      expect(assigns(:representantes)[7]['representatives']).to include(cargo_2)
    end

    it "get an array of representantes searched by nombre or apellidos" do
      partido = create(:partido)
      region = create(:region)
      comuna_1 = create(:comuna)
      comuna_2 = create(:comuna)
      cargo_alcalde = create(:tipo_cargo, :titulo =>"Alcalde", :representante => true, partido_id: partido.id)
      cargo_senador = create(:tipo_cargo, :titulo =>"Senador", :representante => true, partido_id: partido.id)
      persona_1 = create(:persona, :nombre => "Juanito", :apellidos => "Ramirez", :rut => '1-2', :partido_id => partido.id)
      persona_2 = create(:persona, :nombre => "John", :apellidos => "Connor", :rut => '3-4', :partido_id => partido.id)

      cargo_1 = create(:cargo, :partido_id => partido.id, :region_id => region.id, :comuna_id => comuna_1.id, :persona_id => persona_1.id, :tipo_cargo_id => cargo_alcalde.id)
      cargo_2 = create(:cargo, :partido_id => partido.id, :region_id => region.id, :comuna_id => comuna_2.id, :persona_id => persona_2.id, :tipo_cargo_id => cargo_senador.id)

      get :representantes, {:partido_id => partido.to_param, :q => "Juanito Connor"}, valid_session

      expect(assigns(:representantes)[6]['representatives'].count).to eq(1)
      expect(assigns(:representantes)[7]['representatives'].count).to eq(1)
    end

    it "request by gender" do
      partido = create(:partido)
      region_1 = create(:region)
      region_2 = create(:region)
      comuna_1 = create(:comuna)
      comuna_2 = create(:comuna)
      partido.regions << [region_1, region_2]

      cargo_alcalde = create(:tipo_cargo, :titulo =>"Alcalde", :representante => true, partido_id: partido.id)
      cargo_core = create(:tipo_cargo, :titulo =>"CORE", :representante => true, partido_id: partido.id)

      persona_1 = create(:persona, :nombre => "Juanito", :apellidos => "Ramirez", :rut => '1-2', :genero => 'Masculino', :partido_id => partido.id)
      persona_2 = create(:persona, :nombre => "Juana", :apellidos => "Connor", :rut => '3-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_3 = create(:persona, :nombre => "Jean", :apellidos => "Connor", :rut => '4-4', :genero => 'Femenino', :partido_id => partido.id)

      cargo_1 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_1.id, :tipo_cargo_id => cargo_alcalde.id)
      cargo_2 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_2.id, :tipo_cargo_id => cargo_core.id)
      cargo_3 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_3.id, :tipo_cargo_id => cargo_core.id)

      get :representantes, {:partido_id => partido.to_param, :genero => 'Femenino'}, valid_session

      expect(assigns(:representantes)[7]['representatives'].count).to eq(partido.personas.where(:genero => 'Femenino').count)
      expect(assigns(:representantes)[7]['representatives']).to include(cargo_2)
    end

    it "request by region" do
      partido = create(:partido)
      region_1 = create(:region)
      region_2 = create(:region)
      comuna_1 = create(:comuna)
      comuna_2 = create(:comuna)
      partido.regions << [region_1, region_2]

      cargo_alcalde = create(:tipo_cargo, :titulo =>"Alcalde", :representante => true, partido_id: partido.id)
      cargo_core = create(:tipo_cargo, :titulo =>"CORE", :representante => true, partido_id: partido.id)

      persona_1 = create(:persona, :nombre => "Juanito", :apellidos => "Ramirez", :rut => '1-2', :genero => 'Masculino', :partido_id => partido.id)
      persona_2 = create(:persona, :nombre => "Juana", :apellidos => "Connor", :rut => '3-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_3 = create(:persona, :nombre => "Jean", :apellidos => "Connor", :rut => '4-4', :genero => 'Femenino', :partido_id => partido.id)

      cargo_1 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_1.id, :tipo_cargo_id => cargo_alcalde.id)
      cargo_2 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_2.id, :tipo_cargo_id => cargo_core.id)
      cargo_3 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_3.id, :tipo_cargo_id => cargo_core.id)

      get :representantes, {:partido_id => partido.to_param, :region => region_1.id}, valid_session

      expect(assigns(:representantes)[6]['representatives']).to include(cargo_1)
      expect(assigns(:representantes)[7]['representatives']).to include(cargo_2)
    end
  end

  describe "GET #actividades_publicas" do
  end
  describe "GET #intereses_patrimonios" do
    it "array with cargos" do
      partido = create(:partido)

      region_1 = create(:region)
      region_2 = create(:region)

      comuna_1 = create(:comuna)
      comuna_2 = create(:comuna)

      partido.regions << [region_1, region_2]

      tipo_cargo_senador = create(:tipo_cargo, partido_id: partido.id, titulo: "Senador", representante: true, candidato: true)
      tipo_cargo_diputado = create(:tipo_cargo, partido_id: partido.id, titulo: "Diputado", representante: true, candidato: true)
      tipo_cargo_ministro = create(:tipo_cargo, partido_id: partido.id, titulo: "Ministro", autoridad: true)

      persona_1 = create(:persona, :nombre => "Juanito", :apellidos => "Ramirez", :rut => '1-2', :genero => 'Masculino', :partido_id => partido.id)
      persona_2 = create(:persona, :nombre => "Juana", :apellidos => "Connor", :rut => '3-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_3 = create(:persona, :nombre => "Jean", :apellidos => "Connor", :rut => '4-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_4 = create(:persona, :nombre => "Jin", :apellidos => "Connor", :rut => '4-5', :genero => 'Femenino', :partido_id => partido.id)

      cargo_senador_1 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_1.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_senador_2 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_2.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_diputado_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_3.id, :tipo_cargo_id => tipo_cargo_diputado.id)
      cargo_ministro_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_4.id, :tipo_cargo_id => tipo_cargo_ministro.id)

      get :intereses_patrimonios, {:partido_id => partido.to_param}, valid_session

      tc = partido.cargos.map{|c| c.tipo_cargo}.uniq
      expect(assigns(:intereses_patrimonios).count).to eq(tc.count)
    end

    it "search by name" do
      partido = create(:partido)

      region_1 = create(:region)
      region_2 = create(:region)

      comuna_1 = create(:comuna)
      comuna_2 = create(:comuna)

      partido.regions << [region_1, region_2]

      tipo_cargo_senador = create(:tipo_cargo, partido_id: partido.id, titulo: "Senador", representante: true, candidato: true)
      tipo_cargo_diputado = create(:tipo_cargo, partido_id: partido.id, titulo: "Diputado", representante: true, candidato: true)
      tipo_cargo_ministro = create(:tipo_cargo, partido_id: partido.id, titulo: "Ministro", autoridad: true)

      persona_1 = create(:persona, :nombre => "Juanito", :apellidos => "Ramirez", :rut => '1-2', :genero => 'Masculino', :partido_id => partido.id)
      persona_2 = create(:persona, :nombre => "Juana", :apellidos => "Connor", :rut => '3-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_3 = create(:persona, :nombre => "Jean", :apellidos => "Connor", :rut => '4-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_4 = create(:persona, :nombre => "Jin", :apellidos => "Connor", :rut => '4-5', :genero => 'Femenino', :partido_id => partido.id)

      cargo_senador_1 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_1.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_senador_2 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_2.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_diputado_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_3.id, :tipo_cargo_id => tipo_cargo_diputado.id)
      cargo_ministro_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_4.id, :tipo_cargo_id => tipo_cargo_ministro.id)

      get :intereses_patrimonios, {:partido_id => partido.to_param, :q => "Juana"}, valid_session

      tc = partido.tipo_cargos
      personas = Persona.where("lower(personas.nombre) like ? OR lower(personas.apellidos) like ?", "Juana".downcase, "Juana".downcase)
      result = partido.cargos.where(tipo_cargo_id: tc, persona_id: personas)

      expect(assigns(:intereses_patrimonios)[0]['cargos']).to include(result.first)
    end
    it "return by region" do
      partido = create(:partido)

      region_1 = create(:region)
      region_2 = create(:region)

      comuna_1 = create(:comuna)
      comuna_2 = create(:comuna)

      partido.regions << [region_1, region_2]

      tipo_cargo_senador = create(:tipo_cargo, partido_id: partido.id, titulo: "Senador", representante: true, candidato: true)
      tipo_cargo_diputado = create(:tipo_cargo, partido_id: partido.id, titulo: "Diputado", representante: true, candidato: true)
      tipo_cargo_ministro = create(:tipo_cargo, partido_id: partido.id, titulo: "Ministro", autoridad: true)

      persona_1 = create(:persona, :nombre => "Juanito", :apellidos => "Ramirez", :rut => '1-2', :genero => 'Masculino', :partido_id => partido.id)
      persona_2 = create(:persona, :nombre => "Juana", :apellidos => "Connor", :rut => '3-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_3 = create(:persona, :nombre => "Jean", :apellidos => "Connor", :rut => '4-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_4 = create(:persona, :nombre => "Jin", :apellidos => "Connor", :rut => '4-5', :genero => 'Femenino', :partido_id => partido.id)

      cargo_senador_1 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_1.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_senador_2 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_2.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_diputado_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_3.id, :tipo_cargo_id => tipo_cargo_diputado.id)
      cargo_ministro_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_4.id, :tipo_cargo_id => tipo_cargo_ministro.id)

      get :intereses_patrimonios, {:partido_id => partido.to_param, :region => region_1.id}, valid_session

      expect(assigns(:intereses_patrimonios)[0]["cargos"].count).to eq(2)
    end

    it "return by genero" do
      partido = create(:partido)

      region_1 = create(:region)
      region_2 = create(:region)

      comuna_1 = create(:comuna)
      comuna_2 = create(:comuna)

      partido.regions << [region_1, region_2]

      tipo_cargo_senador = create(:tipo_cargo, partido_id: partido.id, titulo: "Senador", representante: true, candidato: true)
      tipo_cargo_diputado = create(:tipo_cargo, partido_id: partido.id, titulo: "Diputado", representante: true, candidato: true)
      tipo_cargo_ministro = create(:tipo_cargo, partido_id: partido.id, titulo: "Ministro", autoridad: true)

      persona_1 = create(:persona, :nombre => "Juanito", :apellidos => "Ramirez", :rut => '1-2', :genero => 'Masculino', :partido_id => partido.id)
      persona_2 = create(:persona, :nombre => "Juana", :apellidos => "Connor", :rut => '3-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_3 = create(:persona, :nombre => "Jean", :apellidos => "Connor", :rut => '4-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_4 = create(:persona, :nombre => "Jin", :apellidos => "Connor", :rut => '4-5', :genero => 'Femenino', :partido_id => partido.id)

      cargo_senador_1 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_1.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_senador_2 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_2.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_diputado_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_3.id, :tipo_cargo_id => tipo_cargo_diputado.id)
      cargo_ministro_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_4.id, :tipo_cargo_id => tipo_cargo_ministro.id)

      get :intereses_patrimonios, {:partido_id => partido.to_param, :genero => "Femenino"}, valid_session

      expect(assigns(:intereses_patrimonios)[0]["cargos"].count).to eq(1)
      expect(assigns(:intereses_patrimonios)[1]["cargos"].count).to eq(1)
    end
  end

  describe "GET #publicacion_candidatos" do
    it "array with cargos" do
      partido = create(:partido)

      region_1 = create(:region)
      region_2 = create(:region)

      comuna_1 = create(:comuna)
      comuna_2 = create(:comuna)

      partido.regions << [region_1, region_2]

      tipo_cargo_senador = create(:tipo_cargo, partido_id: partido.id, titulo: "Senador", representante: true, candidato: true)
      tipo_cargo_diputado = create(:tipo_cargo, partido_id: partido.id, titulo: "Diputado", representante: true, candidato: true)
      tipo_cargo_ministro = create(:tipo_cargo, partido_id: partido.id, titulo: "Ministro", autoridad: true)

      persona_1 = create(:persona, :nombre => "Juanito", :apellidos => "Ramirez", :rut => '1-2', :genero => 'Masculino', :partido_id => partido.id)
      persona_2 = create(:persona, :nombre => "Juana", :apellidos => "Connor", :rut => '3-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_3 = create(:persona, :nombre => "Jean", :apellidos => "Connor", :rut => '4-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_4 = create(:persona, :nombre => "Jin", :apellidos => "Connor", :rut => '4-5', :genero => 'Femenino', :partido_id => partido.id)

      cargo_senador_1 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_1.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_senador_2 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_2.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_diputado_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_3.id, :tipo_cargo_id => tipo_cargo_diputado.id)
      cargo_ministro_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_4.id, :tipo_cargo_id => tipo_cargo_ministro.id)

      get :publicacion_candidatos, {:partido_id => partido.to_param}, valid_session

      cargos_candidato = partido.tipo_cargos.where candidato: true
      expect(assigns(:publicacion_candidatos).count).to eq(cargos_candidato.count)

      senador_id = cargos_candidato.where(titulo:"Senador")
      expect(assigns(:publicacion_candidatos)[0]["cargos"].count).to eq(partido.cargos.where(tipo_cargo_id:senador_id).count)

      ministro_id = cargos_candidato.where(titulo:"Ministro")
      expect(assigns(:publicacion_candidatos)[0]["cargos"]).to_not include(cargo_ministro_1)
    end

    it "search by name" do
      partido = create(:partido)

      region_1 = create(:region)
      region_2 = create(:region)

      comuna_1 = create(:comuna)
      comuna_2 = create(:comuna)

      partido.regions << [region_1, region_2]

      tipo_cargo_senador = create(:tipo_cargo, partido_id: partido.id, titulo: "Senador", representante: true, candidato: true)
      tipo_cargo_diputado = create(:tipo_cargo, partido_id: partido.id, titulo: "Diputado", representante: true, candidato: true)
      tipo_cargo_ministro = create(:tipo_cargo, partido_id: partido.id, titulo: "Ministro", autoridad: true)

      persona_1 = create(:persona, :nombre => "Juanito", :apellidos => "Ramirez", :rut => '1-2', :genero => 'Masculino', :partido_id => partido.id)
      persona_2 = create(:persona, :nombre => "Juana", :apellidos => "Connor", :rut => '3-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_3 = create(:persona, :nombre => "Jean", :apellidos => "Connor", :rut => '4-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_4 = create(:persona, :nombre => "Jin", :apellidos => "Connor", :rut => '4-5', :genero => 'Femenino', :partido_id => partido.id)

      cargo_senador_1 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_1.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_senador_2 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_2.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_diputado_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_3.id, :tipo_cargo_id => tipo_cargo_diputado.id)
      cargo_ministro_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_4.id, :tipo_cargo_id => tipo_cargo_ministro.id)

      get :publicacion_candidatos, {:partido_id => partido.to_param, :q => "Juana"}, valid_session

      tc = partido.tipo_cargos
      personas = Persona.where("lower(personas.nombre) like ? OR lower(personas.apellidos) like ?", "Juana".downcase, "Juana".downcase)
      result = partido.cargos.where(tipo_cargo_id: tc, persona_id: personas)
      expect(assigns(:publicacion_candidatos)[0]["cargos"].count).to eq(result.count)
    end
    it "return by region" do
      partido = create(:partido)

      region_1 = create(:region)
      region_2 = create(:region)

      comuna_1 = create(:comuna)
      comuna_2 = create(:comuna)

      partido.regions << [region_1, region_2]

      tipo_cargo_senador = create(:tipo_cargo, partido_id: partido.id, titulo: "Senador", representante: true, candidato: true)
      tipo_cargo_diputado = create(:tipo_cargo, partido_id: partido.id, titulo: "Diputado", representante: true, candidato: true)
      tipo_cargo_ministro = create(:tipo_cargo, partido_id: partido.id, titulo: "Ministro", autoridad: true)

      persona_1 = create(:persona, :nombre => "Juanito", :apellidos => "Ramirez", :rut => '1-2', :genero => 'Masculino', :partido_id => partido.id)
      persona_2 = create(:persona, :nombre => "Juana", :apellidos => "Connor", :rut => '3-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_3 = create(:persona, :nombre => "Jean", :apellidos => "Connor", :rut => '4-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_4 = create(:persona, :nombre => "Jin", :apellidos => "Connor", :rut => '4-5', :genero => 'Femenino', :partido_id => partido.id)

      cargo_senador_1 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_1.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_senador_2 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_2.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_diputado_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_3.id, :tipo_cargo_id => tipo_cargo_diputado.id)
      cargo_ministro_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_4.id, :tipo_cargo_id => tipo_cargo_ministro.id)

      get :publicacion_candidatos, {:partido_id => partido.to_param, :region => region_1.id}, valid_session

      expect(assigns(:publicacion_candidatos)[0]["cargos"].count).to eq(2)
    end

    it "return by genero" do
      partido = create(:partido)

      region_1 = create(:region)
      region_2 = create(:region)

      comuna_1 = create(:comuna)
      comuna_2 = create(:comuna)

      partido.regions << [region_1, region_2]

      tipo_cargo_senador = create(:tipo_cargo, partido_id: partido.id, titulo: "Senador", representante: true, candidato: true)
      tipo_cargo_diputado = create(:tipo_cargo, partido_id: partido.id, titulo: "Diputado", representante: true, candidato: true)
      tipo_cargo_ministro = create(:tipo_cargo, partido_id: partido.id, titulo: "Ministro", autoridad: true)

      persona_1 = create(:persona, :nombre => "Juanito", :apellidos => "Ramirez", :rut => '1-2', :genero => 'Masculino', :partido_id => partido.id)
      persona_2 = create(:persona, :nombre => "Juana", :apellidos => "Connor", :rut => '3-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_3 = create(:persona, :nombre => "Jean", :apellidos => "Connor", :rut => '4-4', :genero => 'Femenino', :partido_id => partido.id)
      persona_4 = create(:persona, :nombre => "Jin", :apellidos => "Connor", :rut => '4-5', :genero => 'Femenino', :partido_id => partido.id)

      cargo_senador_1 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_1.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_senador_2 = create(:cargo, :partido_id => partido.id, :region_id => region_1.id, :comuna_id => comuna_1.id, :persona_id => persona_2.id, :tipo_cargo_id => tipo_cargo_senador.id)
      cargo_diputado_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_3.id, :tipo_cargo_id => tipo_cargo_diputado.id)
      cargo_ministro_1 = create(:cargo, :partido_id => partido.id, :region_id => region_2.id, :comuna_id => comuna_2.id, :persona_id => persona_4.id, :tipo_cargo_id => tipo_cargo_ministro.id)

      get :publicacion_candidatos, {:partido_id => partido.to_param, :genero => "Femenino"}, valid_session

      expect(assigns(:publicacion_candidatos)[0]["cargos"].count).to eq(1)
      expect(assigns(:publicacion_candidatos)[1]["cargos"].count).to eq(1)
    end
  end
  describe "GET #resultado_elecciones_internas" do
  end
end
