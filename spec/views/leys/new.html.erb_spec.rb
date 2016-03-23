require 'rails_helper'

RSpec.describe "leys/new", type: :view do
  before(:each) do
    assign(:ley, Ley.new(
      :numero => "MyString",
      :nombre => "MyString",
      :enlace => "MyString",
      :tags => "MyString",
      :resumen => "MyString",
      :marco_general => nil
    ))
  end

  xit "renders new ley form" do
    render

    assert_select "form[action=?][method=?]", leys_path, "post" do

      assert_select "input#ley_numero[name=?]", "ley[numero]"

      assert_select "input#ley_nombre[name=?]", "ley[nombre]"

      assert_select "input#ley_enlace[name=?]", "ley[enlace]"

      assert_select "input#ley_tags[name=?]", "ley[tags]"

      assert_select "input#ley_resumen[name=?]", "ley[resumen]"

      assert_select "input#ley_marco_general_id[name=?]", "ley[marco_general_id]"
    end
  end
end
