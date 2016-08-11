require 'rails_helper'

RSpec.describe "ingreso_ordinarios/index", type: :view do
  before(:each) do
    assign(:ingreso_ordinarios, [
      IngresoOrdinario.create!(),
      IngresoOrdinario.create!()
    ])
  end

  it "renders a list of ingreso_ordinarios" do
    render
  end
end
