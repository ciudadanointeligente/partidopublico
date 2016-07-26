require 'rails_helper'

RSpec.describe "ingreso_ordinarios/show", type: :view do
  before(:each) do
    @ingreso_ordinario = assign(:ingreso_ordinario, IngresoOrdinario.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
