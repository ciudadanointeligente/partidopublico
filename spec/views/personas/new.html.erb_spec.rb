require 'rails_helper'

RSpec.describe "personas/new", type: :view do
  before(:each) do
    assign(:persona, Persona.new(
      :genero => "MyString",
      :nivel_estudios => "MyString",
      :region => "MyString",
      :ano_inicio_militancia => 1,
      :afiliado => false,
      :bio => "MyText"
    ))
  end

  it "renders new persona form" do
    render

    assert_select "form[action=?][method=?]", personas_path, "post" do

      assert_select "input#persona_genero[name=?]", "persona[genero]"

      assert_select "input#persona_nivel_estudios[name=?]", "persona[nivel_estudios]"

      assert_select "input#persona_region[name=?]", "persona[region]"

      assert_select "input#persona_ano_inicio_militancia[name=?]", "persona[ano_inicio_militancia]"

      assert_select "input#persona_afiliado[name=?]", "persona[afiliado]"

      assert_select "textarea#persona_bio[name=?]", "persona[bio]"
    end
  end
end
