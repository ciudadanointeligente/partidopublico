require 'rails_helper'

RSpec.describe "marco_internos/show", type: :view do
  before(:each) do
    @marco_interno = assign(:marco_interno, MarcoInterno.create!(
      :partido => nil
    ))
  end

  xit "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
