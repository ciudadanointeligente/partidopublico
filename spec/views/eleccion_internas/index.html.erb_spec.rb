require 'rails_helper'

RSpec.describe "eleccion_internas/index", type: :view do
  before(:each) do
    assign(:eleccion_internas, [
      EleccionInterna.create!(
        :organo_interno => nil,
        :cargo => "Cargo"
      ),
      EleccionInterna.create!(
        :organo_interno => nil,
        :cargo => "Cargo"
      )
    ])
  end

  xit "renders a list of eleccion_internas" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Cargo".to_s, :count => 2
  end
end
