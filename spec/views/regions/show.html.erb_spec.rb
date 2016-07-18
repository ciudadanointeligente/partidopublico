require 'rails_helper'

RSpec.describe "regions/show", type: :view do
  before(:each) do
    @partido = assign(:partido, create(:partido))
    @region = assign(:region, Region.create!(
      :nombre => "Nombre"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nombre/)
  end
end
