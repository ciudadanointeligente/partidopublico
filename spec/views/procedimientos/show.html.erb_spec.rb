require 'rails_helper'

RSpec.describe "procedimientos/show", type: :view do
  before(:each) do
    @procedimiento = assign(:procedimiento, Procedimiento.create!(
      :descripcion => "Descripcion"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Descripcion/)
  end
end
