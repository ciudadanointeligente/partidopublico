require 'rails_helper'

RSpec.describe "contratacions/index", type: :view do
  before(:each) do
    assign(:contratacions, [
      Contratacion.create!(
        :partido => nil,
        :numero => "Numero",
        :individualizacion => "Individualizacion",
        :razon_social => "Razon Social",
        :rut => "Rut",
        :titulares => "Titulares",
        :descripcion => "Descripcion",
        :monto => 1,
        :link => "Link"
      ),
      Contratacion.create!(
        :partido => nil,
        :numero => "Numero",
        :individualizacion => "Individualizacion",
        :razon_social => "Razon Social",
        :rut => "Rut",
        :titulares => "Titulares",
        :descripcion => "Descripcion",
        :monto => 1,
        :link => "Link"
      )
    ])
  end

  xit "renders a list of contratacions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Numero".to_s, :count => 2
    assert_select "tr>td", :text => "Individualizacion".to_s, :count => 2
    assert_select "tr>td", :text => "Razon Social".to_s, :count => 2
    assert_select "tr>td", :text => "Rut".to_s, :count => 2
    assert_select "tr>td", :text => "Titulares".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
  end
end
