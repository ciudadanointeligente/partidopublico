require 'rails_helper'

RSpec.describe "partidos/show", type: :view do
  before(:each) do
    @partido = FactoryGirl.create(:partido)
  end

  it "renders attributes in <p>" do
    render
  end
end
