require 'rails_helper'

RSpec.describe "marco_generals/index", type: :view do
  before(:each) do
    assign(:marco_generals, [
      MarcoGeneral.create!(
        :partido => nil
      ),
      MarcoGeneral.create!(
        :partido => nil
      )
    ])
  end

  it "renders a list of marco_generals" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
