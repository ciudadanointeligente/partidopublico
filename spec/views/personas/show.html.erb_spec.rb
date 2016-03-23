require 'rails_helper'

RSpec.describe "personas/show", type: :view do
  before(:each) do
    @persona = assign(:persona, Persona.create!(
      :genero => "Genero",
      :nivel_estudios => "Nivel Estudios",
      :region => "Region",
      :ano_inicio_militancia => 1,
      :afiliado => false,
      :bio => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Genero/)
    expect(rendered).to match(/Nivel Estudios/)
    expect(rendered).to match(/Region/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
  end
end
