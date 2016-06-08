require 'rails_helper'

RSpec.describe "comunas/new", type: :view do
  before(:each) do
    assign(:comuna, Comuna.new())
  end

  it "renders new comuna form" do
    render

    assert_select "form[action=?][method=?]", comunas_path, "post" do
    end
  end
end
