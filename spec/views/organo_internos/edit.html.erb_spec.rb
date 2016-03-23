require 'rails_helper'

RSpec.describe "organo_internos/edit", type: :view do
  before(:each) do
    @organo_interno = assign(:organo_interno, OrganoInterno.create!(
      :nombre => "MyString",
      :funciones => "MyString"
    ))
  end

  it "renders the edit organo_interno form" do
    render

    assert_select "form[action=?][method=?]", organo_interno_path(@organo_interno), "post" do

      assert_select "input#organo_interno_nombre[name=?]", "organo_interno[nombre]"

      assert_select "input#organo_interno_funciones[name=?]", "organo_interno[funciones]"
    end
  end
end
