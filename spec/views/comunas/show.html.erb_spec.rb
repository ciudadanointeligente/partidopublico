require 'rails_helper'

RSpec.describe "comunas/show", type: :view do
  before(:each) do
    @comuna = assign(:comuna, Comuna.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
