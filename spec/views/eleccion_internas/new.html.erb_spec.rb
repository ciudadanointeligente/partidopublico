require 'rails_helper'

RSpec.describe "eleccion_internas/new", type: :view do
  before(:each) do
    assign(:eleccion_interna, EleccionInterna.new(
      :organo_interno => nil,
      :cargo => "MyString"
    ))
  end

  xit "renders new eleccion_interna form" do
    render

    assert_select "form[action=?][method=?]", eleccion_internas_path, "post" do

      assert_select "input#eleccion_interna_organo_interno_id[name=?]", "eleccion_interna[organo_interno_id]"

      assert_select "input#eleccion_interna_cargo[name=?]", "eleccion_interna[cargo]"
    end
  end
end
