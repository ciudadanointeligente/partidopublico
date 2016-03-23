require 'rails_helper'

RSpec.describe "eleccion_populars/new", type: :view do
  before(:each) do
    assign(:eleccion_popular, EleccionPopular.new(
      :dias => 1,
      :cargo => "MyString"
    ))
  end

  it "renders new eleccion_popular form" do
    render

    assert_select "form[action=?][method=?]", eleccion_populars_path, "post" do

      assert_select "input#eleccion_popular_dias[name=?]", "eleccion_popular[dias]"

      assert_select "input#eleccion_popular_cargo[name=?]", "eleccion_popular[cargo]"
    end
  end
end
