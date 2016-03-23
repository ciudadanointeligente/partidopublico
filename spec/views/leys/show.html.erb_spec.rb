require 'rails_helper'

RSpec.describe "leys/show", type: :view do
  before(:each) do
    @ley = assign(:ley, Ley.create!(
      :numero => "Numero",
      :nombre => "Nombre",
      :enlace => "Enlace",
      :tags => "Tags",
      :resumen => "Resumen",
      :marco_general => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Numero/)
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/Enlace/)
    expect(rendered).to match(/Tags/)
    expect(rendered).to match(/Resumen/)
    expect(rendered).to match(//)
  end
end
