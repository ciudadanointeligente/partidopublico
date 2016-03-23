require 'rails_helper'

RSpec.describe "requisitos/show", type: :view do
  before(:each) do
    @requisito = assign(:requisito, Requisito.create!(
      :descripcion => "Descripcion"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Descripcion/)
  end
end
