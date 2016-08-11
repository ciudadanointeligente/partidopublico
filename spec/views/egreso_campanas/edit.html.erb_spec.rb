require 'rails_helper'

RSpec.describe "egreso_campanas/edit", type: :view do
  before(:each) do
    @egreso_campana = assign(:egreso_campana, EgresoCampana.create!(
      :partido => nil,
      :rut_candidato => "MyString",
      :rut_proveedor => "MyString",
      :nombre => "MyString",
      :proveedor => "MyString",
      :tipo_documento => "MyString",
      :numero_documento => "MyString",
      :numero_cuenta => "MyString",
      :p_o_c => "MyString",
      :glosa => "MyString",
      :monto => 1
    ))
  end

  xit "renders the edit egreso_campana form" do
    render

    assert_select "form[action=?][method=?]", egreso_campana_path(@egreso_campana), "post" do

      assert_select "input#egreso_campana_partido_id[name=?]", "egreso_campana[partido_id]"

      assert_select "input#egreso_campana_rut_candidato[name=?]", "egreso_campana[rut_candidato]"

      assert_select "input#egreso_campana_rut_proveedor[name=?]", "egreso_campana[rut_proveedor]"

      assert_select "input#egreso_campana_nombre[name=?]", "egreso_campana[nombre]"

      assert_select "input#egreso_campana_proveedor[name=?]", "egreso_campana[proveedor]"

      assert_select "input#egreso_campana_tipo_documento[name=?]", "egreso_campana[tipo_documento]"

      assert_select "input#egreso_campana_numero_documento[name=?]", "egreso_campana[numero_documento]"

      assert_select "input#egreso_campana_numero_cuenta[name=?]", "egreso_campana[numero_cuenta]"

      assert_select "input#egreso_campana_p_o_c[name=?]", "egreso_campana[p_o_c]"

      assert_select "input#egreso_campana_glosa[name=?]", "egreso_campana[glosa]"

      assert_select "input#egreso_campana_monto[name=?]", "egreso_campana[monto]"
    end
  end
end
