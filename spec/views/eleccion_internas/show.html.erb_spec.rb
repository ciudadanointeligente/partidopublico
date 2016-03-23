require 'rails_helper'

RSpec.describe "eleccion_internas/show", type: :view do
  before(:each) do
    @eleccion_interna = assign(:eleccion_interna, EleccionInterna.create!(
      :organo_interno => nil,
      :cargo => "Cargo"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Cargo/)
  end
end
