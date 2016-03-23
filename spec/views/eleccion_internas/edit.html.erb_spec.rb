require 'rails_helper'

RSpec.describe "eleccion_internas/edit", type: :view do
  before(:each) do
    @eleccion_interna = assign(:eleccion_interna, EleccionInterna.create!(
      :organo_interno => nil,
      :cargo => "MyString"
    ))
  end

  xit "renders the edit eleccion_interna form" do
    render

    assert_select "form[action=?][method=?]", eleccion_interna_path(@eleccion_interna), "post" do

      assert_select "input#eleccion_interna_organo_interno_id[name=?]", "eleccion_interna[organo_interno_id]"

      assert_select "input#eleccion_interna_cargo[name=?]", "eleccion_interna[cargo]"
    end
  end
end
