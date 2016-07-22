require 'rails_helper'

RSpec.describe "comunas/edit", type: :view do
  before(:each) do
    @partido = assign(:partido, create(:partido))
    @region = assign(:region, create(:region))
    @comuna = assign(:comuna, Comuna.create!())
  end

  it "renders the edit comuna form" do
    render

    assert_select "form[action=?][method=?]", partido_region_comuna_path(@partido, @region, @comuna), "post" do
    end
  end
end
