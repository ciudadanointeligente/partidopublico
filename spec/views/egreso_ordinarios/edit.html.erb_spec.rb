require 'rails_helper'

RSpec.describe "egreso_ordinarios/edit", type: :view do
  before(:each) do
    @egreso_ordinario = assign(:egreso_ordinario, EgresoOrdinario.create!(
      :partido => nil,
      :concepto => "MyString",
      :privado => 1,
      :publico => 1
    ))
  end

  xit "renders the edit egreso_ordinario form" do
    render

    assert_select "form[action=?][method=?]", egreso_ordinario_path(@egreso_ordinario), "post" do

      assert_select "input#egreso_ordinario_partido_id[name=?]", "egreso_ordinario[partido_id]"

      assert_select "input#egreso_ordinario_concepto[name=?]", "egreso_ordinario[concepto]"

      assert_select "input#egreso_ordinario_privado[name=?]", "egreso_ordinario[privado]"

      assert_select "input#egreso_ordinario_publico[name=?]", "egreso_ordinario[publico]"
    end
  end
end
