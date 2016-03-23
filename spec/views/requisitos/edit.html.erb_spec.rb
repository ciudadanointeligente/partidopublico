require 'rails_helper'

RSpec.describe "requisitos/edit", type: :view do
  before(:each) do
    @requisito = assign(:requisito, Requisito.create!(
      :descripcion => "MyString"
    ))
  end

  it "renders the edit requisito form" do
    render

    assert_select "form[action=?][method=?]", requisito_path(@requisito), "post" do

      assert_select "input#requisito_descripcion[name=?]", "requisito[descripcion]"
    end
  end
end
