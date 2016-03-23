require 'rails_helper'

RSpec.describe "marco_generals/new", type: :view do
  before(:each) do
    assign(:marco_general, MarcoGeneral.new(
      :partido => nil
    ))
  end

  xit "renders new marco_general form" do
    render

    assert_select "form[action=?][method=?]", marco_generals_path, "post" do

      assert_select "input#marco_general_partido_id[name=?]", "marco_general[partido_id]"
    end
  end
end
