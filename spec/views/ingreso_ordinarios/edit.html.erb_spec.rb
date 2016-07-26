require 'rails_helper'

RSpec.describe "ingreso_ordinarios/edit", type: :view do
  before(:each) do
    @ingreso_ordinario = assign(:ingreso_ordinario, IngresoOrdinario.create!())
  end

  it "renders the edit ingreso_ordinario form" do
    render

    assert_select "form[action=?][method=?]", ingreso_ordinario_path(@ingreso_ordinario), "post" do
    end
  end
end
