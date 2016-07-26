require 'rails_helper'

RSpec.describe "balance_anuals/edit", type: :view do
  before(:each) do
    @balance_anual = assign(:balance_anual, BalanceAnual.create!(
      :partido => nil,
      :concepto => "MyString",
      :tipo => "MyString",
      :importe => ""
    ))
  end

  xit "renders the edit balance_anual form" do
    render

    assert_select "form[action=?][method=?]", balance_anual_path(@balance_anual), "post" do

      assert_select "input#balance_anual_partido_id[name=?]", "balance_anual[partido_id]"

      assert_select "input#balance_anual_concepto[name=?]", "balance_anual[concepto]"

      assert_select "input#balance_anual_tipo[name=?]", "balance_anual[tipo]"

      assert_select "input#balance_anual_importe[name=?]", "balance_anual[importe]"
    end
  end
end
