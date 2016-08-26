require 'rails_helper'

RSpec.describe "comparisons/show", type: :view do
  before(:each) do
    @comparison = assign(:comparison, Comparison.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
