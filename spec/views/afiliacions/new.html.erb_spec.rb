require 'rails_helper'

RSpec.describe "afiliacions/new", type: :view do
  before(:each) do
    assign(:afiliacion, Afiliacion.new(
      :region => nil,
      :hombres => 1,
      :mujeres => 1,
      :rangos => "MyString"
    ))
  end

  it "renders new afiliacion form" do
    render

    assert_select "form[action=?][method=?]", afiliacions_path, "post" do

      assert_select "input#afiliacion_region_id[name=?]", "afiliacion[region_id]"

      assert_select "input#afiliacion_hombres[name=?]", "afiliacion[hombres]"

      assert_select "input#afiliacion_mujeres[name=?]", "afiliacion[mujeres]"

      assert_select "input#afiliacion_rangos[name=?]", "afiliacion[rangos]"
    end
  end
end
