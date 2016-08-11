require 'rails_helper'

RSpec.describe "ingreso_campanas/show", type: :view do
  before(:each) do
    @ingreso_campana = assign(:ingreso_campana, IngresoCampana.create!(
      :partido => nil,
      :rut_candidato => "Rut Candidato",
      :rut_donante => "Rut Donante",
      :nombre_donante => "Nombre Donante",
      :tipo_documento => "Tipo Documento",
      :numero_documento => "Numero Documento",
      :numero_cuenta => "Numero Cuenta",
      :glosa => "Glosa",
      :monto => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Rut Candidato/)
    expect(rendered).to match(/Rut Donante/)
    expect(rendered).to match(/Nombre Donante/)
    expect(rendered).to match(/Tipo Documento/)
    expect(rendered).to match(/Numero Documento/)
    expect(rendered).to match(/Numero Cuenta/)
    expect(rendered).to match(/Glosa/)
    expect(rendered).to match(/1/)
  end
end
