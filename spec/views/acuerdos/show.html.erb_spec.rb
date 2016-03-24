require 'rails_helper'

RSpec.describe "acuerdos/show", type: :view do
  before(:each) do
    @acuerdo = assign(:acuerdo, Acuerdo.create!(
      :numero => "Numero",
      :tipo => "Tipo",
      :tema => "Tema",
      :region => "Region",
      :organo_interno => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Numero/)
    expect(rendered).to match(/Tipo/)
    expect(rendered).to match(/Tema/)
    expect(rendered).to match(/Region/)
    expect(rendered).to match(//)
  end
end
