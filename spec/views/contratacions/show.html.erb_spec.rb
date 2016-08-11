require 'rails_helper'

RSpec.describe "contratacions/show", type: :view do
  before(:each) do
    @contratacion = assign(:contratacion, Contratacion.create!(
      :partido => nil,
      :numero => "Numero",
      :individualizacion => "Individualizacion",
      :razon_social => "Razon Social",
      :rut => "Rut",
      :titulares => "Titulares",
      :descripcion => "Descripcion",
      :monto => 1,
      :link => "Link"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Numero/)
    expect(rendered).to match(/Individualizacion/)
    expect(rendered).to match(/Razon Social/)
    expect(rendered).to match(/Rut/)
    expect(rendered).to match(/Titulares/)
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Link/)
  end
end
