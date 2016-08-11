require 'rails_helper'

RSpec.describe "transferencias/index", type: :view do
  before(:each) do
    assign(:transferencias, [
      Transferencia.create!(
        :partido => nil,
        :numero => "Numero",
        :razon_social => "Razon Social",
        :rut => "Rut",
        :region => nil,
        :descripcion => "Descripcion",
        :monto => 1,
        :categoria => "Categoria"
      ),
      Transferencia.create!(
        :partido => nil,
        :numero => "Numero",
        :razon_social => "Razon Social",
        :rut => "Rut",
        :region => nil,
        :descripcion => "Descripcion",
        :monto => 1,
        :categoria => "Categoria"
      )
    ])
  end

  xit "renders a list of transferencias" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Numero".to_s, :count => 2
    assert_select "tr>td", :text => "Razon Social".to_s, :count => 2
    assert_select "tr>td", :text => "Rut".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Categoria".to_s, :count => 2
  end
end
