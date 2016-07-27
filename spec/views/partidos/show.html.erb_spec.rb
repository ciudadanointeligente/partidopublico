require 'rails_helper'

RSpec.describe "partidos/show", type: :view do
  before(:each) do
    @partido = FactoryGirl.create(:partido)
    @datos_sedes = []
    @datos_region = []
    @datos_cargos = []
  end

  it "renders attributes in <p>" do
    render
  end
end
