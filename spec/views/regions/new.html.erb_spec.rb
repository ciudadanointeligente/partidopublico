require 'rails_helper'

RSpec.describe "regions/new", type: :view do
  before(:each) do
    @partido =  assign(:partido, create(:partido))
    assign(:region, Region.new(
      :nombre => "MyString"
    ))
  end

  it "renders new region form" do
    render

    assert_select "form[action=?][method=?]", partido_regions_path(@partido, @region), "post" do

      assert_select "input#region_nombre[name=?]", "region[nombre]"
    end
  end
end
