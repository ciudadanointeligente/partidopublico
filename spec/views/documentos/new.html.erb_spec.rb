require 'rails_helper'

RSpec.describe "documentos/new", type: :view do
  before(:each) do
    assign(:documento, Documento.new(
      :descripcion => "MyString"
    ))
  end

  xit "renders new documento form" do
    render

    assert_select "form[action=?][method=?]", documentos_path, "post" do

      assert_select "input#documento_descripcion[name=?]", "documento[descripcion]"
    end
  end
end
