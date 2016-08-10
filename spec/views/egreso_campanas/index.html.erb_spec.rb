require 'rails_helper'

RSpec.describe "egreso_campanas/index", type: :view do
  before(:each) do
    assign(:egreso_campanas, [
      EgresoCampana.create!(
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
      ),
      EgresoCampana.create!(
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
      )
    ])
  end

  xit "renders a list of egreso_campanas" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Rut Candidato".to_s, :count => 2
    assert_select "tr>td", :text => "Rut Proveedor".to_s, :count => 2
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Proveedor".to_s, :count => 2
    assert_select "tr>td", :text => "Tipo Documento".to_s, :count => 2
    assert_select "tr>td", :text => "Numero Documento".to_s, :count => 2
    assert_select "tr>td", :text => "Numero Cuenta".to_s, :count => 2
    assert_select "tr>td", :text => "P O C".to_s, :count => 2
    assert_select "tr>td", :text => "Glosa".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
