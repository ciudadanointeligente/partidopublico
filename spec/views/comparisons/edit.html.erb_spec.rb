require 'rails_helper'

RSpec.describe "comparisons/edit", type: :view do
  before(:each) do
    @comparison = assign(:comparison, Comparison.create!())
  end

  it "renders the edit comparison form" do
    render

    assert_select "form[action=?][method=?]", comparison_path(@comparison), "post" do
    end
  end
end
