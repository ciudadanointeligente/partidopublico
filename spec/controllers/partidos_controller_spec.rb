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
      afiliacion = create(:afiliacion)
      afiliacion.region_id = region.id
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
      tipo_cargo = create(:tipo_cargo)
      persona = create(:persona, :partido_id => partido.id)
      cargo_1 = create(:cargo, :partido_id => partido.id, :region_id => region.id, :comuna_id => comuna.id, :persona_id => persona.id, :tipo_cargo_id => tipo_cargo.id)

      partido.regions << region

      cargos = [{'region' => region.nombre, 'cargos' => [{ 'persona' => cargo_1.persona.nombre, 'cargo' => cargo_1.tipo_cargo.titulo, 'comuna' => cargo_1.comuna.nombre }]}]

      get :autoridades, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:datos_cargos)).to eq(cargos)
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

end
