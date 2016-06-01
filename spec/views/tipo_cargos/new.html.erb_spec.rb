require 'rails_helper'

RSpec.describe "tipo_cargos/new", type: :view do
  before(:each) do
    assign(:tipo_cargo, TipoCargo.new(
      :titulo => "MyString"
    ))
  end

  it "renders new tipo_cargo form" do
    render

    assert_select "form[action=?][method=?]", tipo_cargos_path, "post" do

      assert_select "input#tipo_cargo_titulo[name=?]", "tipo_cargo[titulo]"
    end
  end
end
