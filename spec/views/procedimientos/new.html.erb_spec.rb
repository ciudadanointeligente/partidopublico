require 'rails_helper'

RSpec.describe "procedimientos/new", type: :view do
  before(:each) do
    assign(:procedimiento, Procedimiento.new(
      :descripcion => "MyString"
    ))
  end

  it "renders new procedimiento form" do
    render

    assert_select "form[action=?][method=?]", procedimientos_path, "post" do

      assert_select "input#procedimiento_descripcion[name=?]", "procedimiento[descripcion]"
    end
  end
end
