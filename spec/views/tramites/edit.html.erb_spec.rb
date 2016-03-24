require 'rails_helper'

RSpec.describe "tramites/edit", type: :view do
  before(:each) do
    @tramite = assign(:tramite, Tramite.create!(
      :nombre => "MyString",
      :descripcion => "MyString",
      :persona => nil
    ))
  end

  xit "renders the edit tramite form" do
    render

    assert_select "form[action=?][method=?]", tramite_path(@tramite), "post" do

      assert_select "input#tramite_nombre[name=?]", "tramite[nombre]"

      assert_select "input#tramite_descripcion[name=?]", "tramite[descripcion]"

      assert_select "input#tramite_persona_id[name=?]", "tramite[persona_id]"
    end
  end
end
