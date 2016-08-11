require 'rails_helper'

RSpec.describe "comunas/new", type: :view do
  before(:each) do
    @partido = assign(:partido, create(:partido))
    @region = assign(:region, create(:region))
    assign(:comuna, Comuna.new())
  end

  it "renders new comuna form" do
    render

    assert_select "form[action=?][method=?]", partido_region_comunas_path(@partido, @region), "post" do
    end
  end
end
