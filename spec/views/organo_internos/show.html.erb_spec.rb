require 'rails_helper'

RSpec.describe "organo_internos/show", type: :view do
  before(:each) do
    partido = create(:partido)
    @organo_interno = assign(:organo_interno, OrganoInterno.create!(
      :nombre => "Nombre",
      :funciones => "Funciones",
      :partido_id => partido.id
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/Funciones/)
  end
end
