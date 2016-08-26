require 'rails_helper'

RSpec.describe "comparisons/new", type: :view do
  before(:each) do
    assign(:comparison, Comparison.new())
  end

  it "renders new comparison form" do
    render

    assert_select "form[action=?][method=?]", comparisons_path, "post" do
    end
  end
end
