require 'rails_helper'

RSpec.describe "tipo_cargos/show", type: :view do
  before(:each) do
    @tipo_cargo = assign(:tipo_cargo, TipoCargo.create!(
      :titulo => "Titulo"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Titulo/)
  end
end
