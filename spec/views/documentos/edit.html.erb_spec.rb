require 'rails_helper'

RSpec.describe "documentos/edit", type: :view do
  before(:each) do
    @documento = assign(:documento, Documento.create!(
      :descripcion => "MyString"
    ))
  end

  xit "renders the edit documento form" do
    render

    assert_select "form[action=?][method=?]", documento_path(@documento), "post" do

      assert_select "input#documento_descripcion[name=?]", "documento[descripcion]"
    end
  end
end
