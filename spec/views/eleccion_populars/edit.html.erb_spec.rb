require 'rails_helper'

RSpec.describe "eleccion_populars/edit", type: :view do
  before(:each) do
    @eleccion_popular = assign(:eleccion_popular, EleccionPopular.create!(
      :dias => 1,
      :cargo => "MyString"
    ))
  end

  it "renders the edit eleccion_popular form" do
    render

    assert_select "form[action=?][method=?]", eleccion_popular_path(@eleccion_popular), "post" do

      assert_select "input#eleccion_popular_dias[name=?]", "eleccion_popular[dias]"

      assert_select "input#eleccion_popular_cargo[name=?]", "eleccion_popular[cargo]"
    end
  end
end
