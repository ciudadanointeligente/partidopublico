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
      region = create(:region)
      afiliacion = create(:afiliacion, :partido_id => partido.id, :region_id => region.id)
      #afiliacion.region_id = region.id
      partido.regions << region
      partido.afiliacions << afiliacion

      nacional = { "region" => "nacional", "ordinal" => "nacional", "hombres" => 10, "mujeres" => 20, "porcentaje_hombres" => 33, "porcentaje_mujeres" => 66, "total" => 30, "desgloce" => [{"14-17"=>0, "18-24"=>0, "25-29"=>0, "30-34"=>0, "35-39"=>30, "40-44"=>0, "45-49"=>0, "50-54"=>0, "55-59"=>0, "60-64"=>0, "65-69"=>0, "70-100"=>0}] }
      regional = { "region" => "MyString", "ordinal" => "MS", "hombres" => 10, "mujeres" => 20, "porcentaje_hombres" => 33, "porcentaje_mujeres" => 66, "total" => 30, "desgloce" => [{"14-17"=>0},{"18-24"=>0},{"25-29"=>0},{"30-34"=>0},{"35-39"=>30},{"40-44"=>0},{"45-49"=>0},{"50-54"=>0},{"55-59"=>0},{"60-64"=>0},{"65-69"=>0},{"70-100"=>0}] }
      total_nacional = []
      total_nacional << nacional
      total_nacional << regional

      get :regiones, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:datos_total_nacional)).not_to be_empty
      expect(assigns(:datos_total_nacional)).to eq(total_nacional)
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
    it "return an array with all autorities of a party by region" do
      partido = create(:partido)
      region = create(:region)
      comuna = create(:comuna)
      tipo_cargo = create(:tipo_cargo, :autoridad => true)
      persona = create(:persona, :partido_id => partido.id)
      cargo_1 = create(:cargo, :partido_id => partido.id, :region_id => region.id, :comuna_id => comuna.id, :persona_id => persona.id, :tipo_cargo_id => tipo_cargo.id)

      partido.regions << region

      # cargos = [{'region' => region.nombre, 'cargos' => [{ 'persona' => cargo_1.persona.nombre, 'cargo' => cargo_1.tipo_cargo.titulo, 'comuna' => cargo_1.comuna.nombre }]}]

      get :autoridades, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:autoridades)).to include(cargo_1)
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

end
