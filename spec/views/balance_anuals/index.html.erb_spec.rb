require 'rails_helper'

RSpec.describe "balance_anuals/index", type: :view do
  before(:each) do
    assign(:balance_anuals, [
      BalanceAnual.create!(
        :partido => nil,
        :concepto => "Concepto",
        :tipo => "Tipo",
        :importe => ""
      ),
      BalanceAnual.create!(
        :partido => nil,
        :concepto => "Concepto",
        :tipo => "Tipo",
        :importe => ""
      )
    ])
  end

  xit "renders a list of balance_anuals" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Concepto".to_s, :count => 2
    assert_select "tr>td", :text => "Tipo".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
