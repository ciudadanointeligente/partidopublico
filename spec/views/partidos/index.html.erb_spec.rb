require 'rails_helper'

RSpec.describe "partidos/index", type: :view do
  before(:each) do
    assign(:partidos, [
      FactoryGirl.create(:partido1),
      FactoryGirl.create(:partido2)
    ])
  end

  it "renders a list of partidos" do
    render
  end
end
