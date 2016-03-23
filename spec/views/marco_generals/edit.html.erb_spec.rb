require 'rails_helper'

RSpec.describe "marco_generals/edit", type: :view do
  before(:each) do
    @marco_general = assign(:marco_general, MarcoGeneral.create!(
      :partido => nil
    ))
  end

  xit "renders the edit marco_general form" do
    render

    assert_select "form[action=?][method=?]", marco_general_path(@marco_general), "post" do

      assert_select "input#marco_general_partido_id[name=?]", "marco_general[partido_id]"
    end
  end
end
