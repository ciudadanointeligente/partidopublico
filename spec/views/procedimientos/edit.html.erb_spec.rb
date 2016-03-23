require 'rails_helper'

RSpec.describe "procedimientos/edit", type: :view do
  before(:each) do
    @procedimiento = assign(:procedimiento, Procedimiento.create!(
      :descripcion => "MyString"
    ))
  end

  it "renders the edit procedimiento form" do
    render

    assert_select "form[action=?][method=?]", procedimiento_path(@procedimiento), "post" do

      assert_select "input#procedimiento_descripcion[name=?]", "procedimiento[descripcion]"
    end
  end
end
