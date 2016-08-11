require 'rails_helper'

RSpec.describe "egreso_ordinarios/show", type: :view do
  before(:each) do
    @egreso_ordinario = assign(:egreso_ordinario, EgresoOrdinario.create!(
      :partido => nil,
      :concepto => "Concepto",
      :privado => 1,
      :publico => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Concepto/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
