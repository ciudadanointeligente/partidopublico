require 'rails_helper'

RSpec.describe "leys/index", type: :view do
  before(:each) do
    assign(:leys, [
      Ley.create!(
        :numero => "Numero",
        :nombre => "Nombre",
        :enlace => "Enlace",
        :tags => "Tags",
        :resumen => "Resumen",
        :marco_general => nil
      ),
      Ley.create!(
        :numero => "Numero",
        :nombre => "Nombre",
        :enlace => "Enlace",
        :tags => "Tags",
        :resumen => "Resumen",
        :marco_general => nil
      )
    ])
  end

  it "renders a list of leys" do
    render
    assert_select "tr>td", :text => "Numero".to_s, :count => 2
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Enlace".to_s, :count => 2
    assert_select "tr>td", :text => "Tags".to_s, :count => 2
    assert_select "tr>td", :text => "Resumen".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
