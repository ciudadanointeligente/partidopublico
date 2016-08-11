require 'rails_helper'

RSpec.describe "ingreso_ordinarios/new", type: :view do
  before(:each) do
    assign(:ingreso_ordinario, IngresoOrdinario.new())
  end

  it "renders new ingreso_ordinario form" do
    render

    assert_select "form[action=?][method=?]", ingreso_ordinarios_path, "post" do
    end
  end
end
