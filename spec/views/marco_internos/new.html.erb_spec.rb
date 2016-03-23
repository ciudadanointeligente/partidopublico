require 'rails_helper'

RSpec.describe "marco_internos/new", type: :view do
  before(:each) do
    assign(:marco_interno, MarcoInterno.new(
      :partido => nil
    ))
  end

  xit "renders new marco_interno form" do
    render

    assert_select "form[action=?][method=?]", marco_internos_path, "post" do

      assert_select "input#marco_interno_partido_id[name=?]", "marco_interno[partido_id]"
    end
  end
end
