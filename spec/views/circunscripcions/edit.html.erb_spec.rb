require 'rails_helper'

RSpec.describe "circunscripcions/edit", type: :view do
  before(:each) do
    @circunscripcion = assign(:circunscripcion, Circunscripcion.create!())
  end

  it "renders the edit circunscripcion form" do
    render

    assert_select "form[action=?][method=?]", circunscripcion_path(@circunscripcion), "post" do
    end
  end
end
