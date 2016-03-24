require 'rails_helper'

RSpec.describe "sedes/edit", type: :view do
  before(:each) do
    @sede = assign(:sede, Sede.create!(
      :region => "MyString",
      :direccion => "MyString",
      :contacto => "MyString"
    ))
  end

  it "renders the edit sede form" do
    render

    assert_select "form[action=?][method=?]", sede_path(@sede), "post" do

      assert_select "input#sede_region[name=?]", "sede[region]"

      assert_select "input#sede_direccion[name=?]", "sede[direccion]"

      assert_select "input#sede_contacto[name=?]", "sede[contacto]"
    end
  end
end
