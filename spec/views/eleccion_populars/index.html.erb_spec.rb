require 'rails_helper'

RSpec.describe "eleccion_populars/index", type: :view do
  before(:each) do
    assign(:eleccion_populars, [
      EleccionPopular.create!(
        :dias => 1,
        :cargo => "Cargo"
      ),
      EleccionPopular.create!(
        :dias => 1,
        :cargo => "Cargo"
      )
    ])
  end

  it "renders a list of eleccion_populars" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Cargo".to_s, :count => 2
  end
end
