require 'rails_helper'

RSpec.describe "balance_anuals/new", type: :view do
  before(:each) do
    assign(:balance_anual, BalanceAnual.new(
      :partido => nil,
      :concepto => "MyString",
      :tipo => "MyString",
      :importe => ""
    ))
  end

  xit "renders new balance_anual form" do
    render

    assert_select "form[action=?][method=?]", balance_anuals_path, "post" do

      assert_select "input#balance_anual_partido_id[name=?]", "balance_anual[partido_id]"

      assert_select "input#balance_anual_concepto[name=?]", "balance_anual[concepto]"

      assert_select "input#balance_anual_tipo[name=?]", "balance_anual[tipo]"

      assert_select "input#balance_anual_importe[name=?]", "balance_anual[importe]"
    end
  end
end
