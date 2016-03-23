require 'rails_helper'

RSpec.describe "organo_internos/index", type: :view do
  before(:each) do
    assign(:organo_internos, [
      OrganoInterno.create!(
        :nombre => "Nombre",
        :funciones => "Funciones"
      ),
      OrganoInterno.create!(
        :nombre => "Nombre",
        :funciones => "Funciones"
      )
    ])
  end

  it "renders a list of organo_internos" do
    render
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Funciones".to_s, :count => 2
  end
end
