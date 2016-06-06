require 'rails_helper'

RSpec.describe "comunas/edit", type: :view do
  before(:each) do
    @comuna = assign(:comuna, Comuna.create!())
  end

  it "renders the edit comuna form" do
    render

    assert_select "form[action=?][method=?]", comuna_path(@comuna), "post" do
    end
  end
end
