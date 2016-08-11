require 'rails_helper'

RSpec.describe "ingreso_campanas/new", type: :view do
  before(:each) do
    assign(:ingreso_campana, IngresoCampana.new(
      :partido => nil,
      :rut_candidato => "MyString",
      :rut_donante => "MyString",
      :nombre_donante => "MyString",
      :tipo_documento => "MyString",
      :numero_documento => "MyString",
      :numero_cuenta => "MyString",
      :glosa => "MyString",
      :monto => 1
    ))
  end

  xit "renders new ingreso_campana form" do
    render

    assert_select "form[action=?][method=?]", ingreso_campanas_path, "post" do

      assert_select "input#ingreso_campana_partido_id[name=?]", "ingreso_campana[partido_id]"

      assert_select "input#ingreso_campana_rut_candidato[name=?]", "ingreso_campana[rut_candidato]"

      assert_select "input#ingreso_campana_rut_donante[name=?]", "ingreso_campana[rut_donante]"

      assert_select "input#ingreso_campana_nombre_donante[name=?]", "ingreso_campana[nombre_donante]"

      assert_select "input#ingreso_campana_tipo_documento[name=?]", "ingreso_campana[tipo_documento]"

      assert_select "input#ingreso_campana_numero_documento[name=?]", "ingreso_campana[numero_documento]"

      assert_select "input#ingreso_campana_numero_cuenta[name=?]", "ingreso_campana[numero_cuenta]"

      assert_select "input#ingreso_campana_glosa[name=?]", "ingreso_campana[glosa]"

      assert_select "input#ingreso_campana_monto[name=?]", "ingreso_campana[monto]"
    end
  end
end
