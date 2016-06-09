require 'rails_helper'

RSpec.describe "actividad_publicas/edit", type: :view do
  before(:each) do
    @actividad_publica = assign(:actividad_publica, ActividadPublica.create!())
  end

  it "renders the edit actividad_publica form" do
    render

    assert_select "form[action=?][method=?]", actividad_publica_path(@actividad_publica), "post" do
    end
  end
end
