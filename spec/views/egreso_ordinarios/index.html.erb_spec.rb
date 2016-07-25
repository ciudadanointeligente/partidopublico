require 'rails_helper'

RSpec.describe "egreso_ordinarios/index", type: :view do
  before(:each) do
    assign(:egreso_ordinarios, [
      EgresoOrdinario.create!(
        :partido => nil,
        :concepto => "Concepto",
        :privado => 1,
        :publico => 2
      ),
      EgresoOrdinario.create!(
        :partido => nil,
        :concepto => "Concepto",
        :privado => 1,
        :publico => 2
      )
    ])
  end

  it "renders a list of egreso_ordinarios" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Concepto".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
