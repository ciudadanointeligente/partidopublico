require 'rails_helper'

RSpec.describe "comparisons/index", type: :view do
  before(:each) do
    assign(:comparisons, [
      Comparison.create!(),
      Comparison.create!()
    ])
  end

  it "renders a list of comparisons" do
    render
  end
end
