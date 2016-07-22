require 'rails_helper'

RSpec.describe "comunas/show", type: :view do
  before(:each) do
    @partido = assign(:partido, create(:partido))
    @region = assign(:region, create(:region))
    @comuna = assign(:comuna, Comuna.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
