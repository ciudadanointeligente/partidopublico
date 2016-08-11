require 'rails_helper'

RSpec.describe "contratacions/edit", type: :view do
  before(:each) do
    @contratacion = assign(:contratacion, Contratacion.create!(
      :partido => nil,
      :numero => "MyString",
      :individualizacion => "MyString",
      :razon_social => "MyString",
      :rut => "MyString",
      :titulares => "MyString",
      :descripcion => "MyString",
      :monto => 1,
      :link => "MyString"
    ))
  end

  xit "renders the edit contratacion form" do
    render

    assert_select "form[action=?][method=?]", contratacion_path(@contratacion), "post" do

      assert_select "input#contratacion_partido_id[name=?]", "contratacion[partido_id]"

      assert_select "input#contratacion_numero[name=?]", "contratacion[numero]"

      assert_select "input#contratacion_individualizacion[name=?]", "contratacion[individualizacion]"

      assert_select "input#contratacion_razon_social[name=?]", "contratacion[razon_social]"

      assert_select "input#contratacion_rut[name=?]", "contratacion[rut]"

      assert_select "input#contratacion_titulares[name=?]", "contratacion[titulares]"

      assert_select "input#contratacion_descripcion[name=?]", "contratacion[descripcion]"

      assert_select "input#contratacion_monto[name=?]", "contratacion[monto]"

      assert_select "input#contratacion_link[name=?]", "contratacion[link]"
    end
  end
end
