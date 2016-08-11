require 'rails_helper'

RSpec.describe "regions/edit", type: :view do
  before(:each) do
    @partido = assign(:partido, create(:partido))
    @region = assign(:region, Region.create!(
      :nombre => "MyString"
    ))
  end

  it "renders the edit region form" do
    render

    assert_select "form[action=?][method=?]", partido_region_path(@partido, @region), "post" do

      assert_select "input#region_nombre[name=?]", "region[nombre]"
    end
  end
end
