require 'rails_helper'

RSpec.describe "eleccion_populars/show", type: :view do
  before(:each) do
    @eleccion_popular = assign(:eleccion_popular, EleccionPopular.create!(
      :dias => 1,
      :cargo => "Cargo"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Cargo/)
  end
end
