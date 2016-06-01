require 'rails_helper'

RSpec.describe "tipo_cargos/edit", type: :view do
  before(:each) do
    @tipo_cargo = assign(:tipo_cargo, TipoCargo.create!(
      :titulo => "MyString"
    ))
  end

  it "renders the edit tipo_cargo form" do
    render

    assert_select "form[action=?][method=?]", tipo_cargo_path(@tipo_cargo), "post" do

      assert_select "input#tipo_cargo_titulo[name=?]", "tipo_cargo[titulo]"
    end
  end
end
