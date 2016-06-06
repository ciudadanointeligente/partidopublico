require 'rails_helper'

RSpec.describe "circunscripcions/index", type: :view do
  before(:each) do
    assign(:circunscripcions, [
      Circunscripcion.create!(),
      Circunscripcion.create!()
    ])
  end

  it "renders a list of circunscripcions" do
    render
  end
end
