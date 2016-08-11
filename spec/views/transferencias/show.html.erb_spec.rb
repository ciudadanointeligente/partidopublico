require 'rails_helper'

RSpec.describe "transferencias/show", type: :view do
  before(:each) do
    @transferencia = assign(:transferencia, Transferencia.create!(
      :partido => nil,
      :numero => "Numero",
      :razon_social => "Razon Social",
      :rut => "Rut",
      :region => nil,
      :descripcion => "Descripcion",
      :monto => 1,
      :categoria => "Categoria"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Numero/)
    expect(rendered).to match(/Razon Social/)
    expect(rendered).to match(/Rut/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Categoria/)
  end
end
