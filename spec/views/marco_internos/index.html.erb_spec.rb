require 'rails_helper'

RSpec.describe "marco_internos/index", type: :view do
  before(:each) do
    assign(:marco_internos, [
      MarcoInterno.create!(
        :partido => nil
      ),
      MarcoInterno.create!(
        :partido => nil
      )
    ])
  end

  it "renders a list of marco_internos" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
