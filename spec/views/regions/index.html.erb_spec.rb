require 'rails_helper'

RSpec.describe "regions/index", type: :view do
  before(:each) do
    assign(:regions, [
      Region.create!(
        :nombre => "Nombre"
      ),
      Region.create!(
        :nombre => "Nombre"
      )
    ])
  end

  it "renders a list of regions" do
    render
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
  end
end
