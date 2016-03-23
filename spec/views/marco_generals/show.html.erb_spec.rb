require 'rails_helper'

RSpec.describe "marco_generals/show", type: :view do
  before(:each) do
    @marco_general = assign(:marco_general, MarcoGeneral.create!(
      :partido => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
