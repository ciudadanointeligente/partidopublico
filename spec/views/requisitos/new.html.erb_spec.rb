require 'rails_helper'

RSpec.describe "requisitos/new", type: :view do
  before(:each) do
    assign(:requisito, Requisito.new(
      :descripcion => "MyString"
    ))
  end

  it "renders new requisito form" do
    render

    assert_select "form[action=?][method=?]", requisitos_path, "post" do

      assert_select "input#requisito_descripcion[name=?]", "requisito[descripcion]"
    end
  end
end
