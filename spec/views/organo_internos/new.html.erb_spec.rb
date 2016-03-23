require 'rails_helper'

RSpec.describe "organo_internos/new", type: :view do
  before(:each) do
    assign(:organo_interno, OrganoInterno.new(
      :nombre => "MyString",
      :funciones => "MyString"
    ))
  end

  it "renders new organo_interno form" do
    render

    assert_select "form[action=?][method=?]", organo_internos_path, "post" do

      assert_select "input#organo_interno_nombre[name=?]", "organo_interno[nombre]"

      assert_select "input#organo_interno_funciones[name=?]", "organo_interno[funciones]"
    end
  end
end
