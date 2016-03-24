require 'rails_helper'

RSpec.describe "tramites/new", type: :view do
  before(:each) do
    assign(:tramite, Tramite.new(
      :nombre => "MyString",
      :descripcion => "MyString",
      :persona => nil
    ))
  end

  xit "renders new tramite form" do
    render

    assert_select "form[action=?][method=?]", tramites_path, "post" do

      assert_select "input#tramite_nombre[name=?]", "tramite[nombre]"

      assert_select "input#tramite_descripcion[name=?]", "tramite[descripcion]"

      assert_select "input#tramite_persona_id[name=?]", "tramite[persona_id]"
    end
  end
end
