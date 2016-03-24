require 'rails_helper'

RSpec.describe "tramites/show", type: :view do
  before(:each) do
    @tramite = assign(:tramite, Tramite.create!(
      :nombre => "Nombre",
      :descripcion => "Descripcion",
      :persona => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/Descripcion/)
    expect(rendered).to match(//)
  end
end
