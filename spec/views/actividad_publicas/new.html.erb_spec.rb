require 'rails_helper'

RSpec.describe "actividad_publicas/new", type: :view do
  before(:each) do
    assign(:actividad_publica, ActividadPublica.new())
  end

  it "renders new actividad_publica form" do
    render

    assert_select "form[action=?][method=?]", actividad_publicas_path, "post" do
    end
  end
end
