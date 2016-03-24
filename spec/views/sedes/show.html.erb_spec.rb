require 'rails_helper'

RSpec.describe "sedes/show", type: :view do
  before(:each) do
    @sede = assign(:sede, Sede.create!(
      :region => "Region",
      :direccion => "Direccion",
      :contacto => "Contacto"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Region/)
    expect(rendered).to match(/Direccion/)
    expect(rendered).to match(/Contacto/)
  end
end
