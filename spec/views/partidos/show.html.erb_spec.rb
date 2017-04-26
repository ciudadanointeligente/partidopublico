require 'rails_helper'

RSpec.describe "partidos/show", type: :view do
  before(:each) do
    new_document = create(:documento)
    @partido = FactoryGirl.create(:partido)
    @partido.marco_interno = create(:marco_interno)
    @partido.marco_interno.documentos << new_document
    @datos_sedes = []
    @datos_region = []
    @datos_cargos = []
  end

  it "renders attributes in <p>" do
    render
  end
end
