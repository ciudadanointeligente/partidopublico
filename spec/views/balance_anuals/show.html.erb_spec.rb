require 'rails_helper'

RSpec.describe "balance_anuals/show", type: :view do
  before(:each) do
    @balance_anual = assign(:balance_anual, BalanceAnual.create!(
      :partido => nil,
      :concepto => "Concepto",
      :tipo => "Tipo",
      :importe => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Concepto/)
    expect(rendered).to match(/Tipo/)
    expect(rendered).to match(//)
  end
end
