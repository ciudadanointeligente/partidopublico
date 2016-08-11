require 'rails_helper'

RSpec.describe "ingreso_campanas/index", type: :view do
  before(:each) do
    assign(:ingreso_campanas, [
      IngresoCampana.create!(
        :partido => nil,
        :rut_candidato => "Rut Candidato",
        :rut_donante => "Rut Donante",
        :nombre_donante => "Nombre Donante",
        :tipo_documento => "Tipo Documento",
        :numero_documento => "Numero Documento",
        :numero_cuenta => "Numero Cuenta",
        :glosa => "Glosa",
        :monto => 1
      ),
      IngresoCampana.create!(
        :partido => nil,
        :rut_candidato => "Rut Candidato",
        :rut_donante => "Rut Donante",
        :nombre_donante => "Nombre Donante",
        :tipo_documento => "Tipo Documento",
        :numero_documento => "Numero Documento",
        :numero_cuenta => "Numero Cuenta",
        :glosa => "Glosa",
        :monto => 1
      )
    ])
  end

  xit "renders a list of ingreso_campanas" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Rut Candidato".to_s, :count => 2
    assert_select "tr>td", :text => "Rut Donante".to_s, :count => 2
    assert_select "tr>td", :text => "Nombre Donante".to_s, :count => 2
    assert_select "tr>td", :text => "Tipo Documento".to_s, :count => 2
    assert_select "tr>td", :text => "Numero Documento".to_s, :count => 2
    assert_select "tr>td", :text => "Numero Cuenta".to_s, :count => 2
    assert_select "tr>td", :text => "Glosa".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
