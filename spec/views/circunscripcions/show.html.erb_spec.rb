require 'rails_helper'

RSpec.describe "circunscripcions/show", type: :view do
  before(:each) do
    @circunscripcion = assign(:circunscripcion, Circunscripcion.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
