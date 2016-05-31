require 'rails_helper'

RSpec.describe "sedes/index", type: :view do
  before(:each) do
    assign(:sedes, [
      Sede.create!(
        :region => "Region",
        :direccion => "Direccion",
        :contacto => "Contacto"
      ),
      Sede.create!(
        :region => "Region",
        :direccion => "Direccion",
        :contacto => "Contacto"
      )
    ])
  end

  it "renders a list of sedes" do
    render
    assert_select "tr>td", :text => "Region".to_s, :count => 2
    assert_select "tr>td", :text => "Direccion".to_s, :count => 2
    assert_select "tr>td", :text => "Contacto".to_s, :count => 2
  end
end
