require 'rails_helper'

RSpec.describe "sedes/new", type: :view do
  before(:each) do
    assign(:sede, Sede.new(
      :region => "MyString",
      :direccion => "MyString",
      :contacto => "MyString"
    ))
  end

  it "renders new sede form" do
    render

    assert_select "form[action=?][method=?]", sedes_path, "post" do

      assert_select "input#sede_region[name=?]", "sede[region]"

      assert_select "input#sede_direccion[name=?]", "sede[direccion]"

      assert_select "input#sede_contacto[name=?]", "sede[contacto]"
    end
  end
end
