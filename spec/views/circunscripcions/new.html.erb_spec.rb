require 'rails_helper'

RSpec.describe "circunscripcions/new", type: :view do
  before(:each) do
    assign(:circunscripcion, Circunscripcion.new())
  end

  it "renders new circunscripcion form" do
    render

    assert_select "form[action=?][method=?]", circunscripcions_path, "post" do
    end
  end
end
