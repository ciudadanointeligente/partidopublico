require 'rails_helper'

RSpec.describe "personas/index", type: :view do
  before(:each) do
    assign(:personas, [
      Persona.create!(
        :genero => "Genero",
        :nivel_estudios => "Nivel Estudios",
        :region => "Region",
        :ano_inicio_militancia => 1,
        :afiliado => false,
        :bio => "MyText"
      ),
      Persona.create!(
        :genero => "Genero",
        :nivel_estudios => "Nivel Estudios",
        :region => "Region",
        :ano_inicio_militancia => 1,
        :afiliado => false,
        :bio => "MyText"
      )
    ])
  end

  it "renders a list of personas" do
    render
    assert_select "tr>td", :text => "Genero".to_s, :count => 2
    assert_select "tr>td", :text => "Nivel Estudios".to_s, :count => 2
    assert_select "tr>td", :text => "Region".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
