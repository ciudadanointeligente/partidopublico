require 'rails_helper'

RSpec.describe "transferencias/new", type: :view do
  before(:each) do
    assign(:transferencia, Transferencia.new(
      :partido => nil,
      :numero => "MyString",
      :razon_social => "MyString",
      :rut => "MyString",
      :region => nil,
      :descripcion => "MyString",
      :monto => 1,
      :categoria => "MyString"
    ))
  end

  xit "renders new transferencia form" do
    render

    assert_select "form[action=?][method=?]", transferencias_path, "post" do

      assert_select "input#transferencia_partido_id[name=?]", "transferencia[partido_id]"

      assert_select "input#transferencia_numero[name=?]", "transferencia[numero]"

      assert_select "input#transferencia_razon_social[name=?]", "transferencia[razon_social]"

      assert_select "input#transferencia_rut[name=?]", "transferencia[rut]"

      assert_select "input#transferencia_region_id[name=?]", "transferencia[region_id]"

      assert_select "input#transferencia_descripcion[name=?]", "transferencia[descripcion]"

      assert_select "input#transferencia_monto[name=?]", "transferencia[monto]"

      assert_select "input#transferencia_categoria[name=?]", "transferencia[categoria]"
    end
  end
end
