require 'rails_helper'

RSpec.describe "egreso_campanas/show", type: :view do
  before(:each) do
    @egreso_campana = assign(:egreso_campana, EgresoCampana.create!(
      :partido => nil,
      :rut_candidato => "Rut Candidato",
      :rut_proveedor => "Rut Proveedor",
      :nombre => "Nombre",
      :proveedor => "Proveedor",
      :tipo_documento => "Tipo Documento",
      :numero_documento => "Numero Documento",
      :numero_cuenta => "Numero Cuenta",
      :p_o_c => "P O C",
      :glosa => "Glosa",
      :monto => 1
    ))
  end

  xit "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Rut Candidato/)
    expect(rendered).to match(/Rut Proveedor/)
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/Proveedor/)
    expect(rendered).to match(/Tipo Documento/)
    expect(rendered).to match(/Numero Documento/)
    expect(rendered).to match(/Numero Cuenta/)
    expect(rendered).to match(/P O C/)
    expect(rendered).to match(/Glosa/)
    expect(rendered).to match(/1/)
  end
end
