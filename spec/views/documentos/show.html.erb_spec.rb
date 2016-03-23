require 'rails_helper'

RSpec.describe "documentos/show", type: :view do
  before(:each) do
    @documento = assign(:documento, Documento.create!(
      :descripcion => "Descripcion"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Descripcion/)
  end
end
