require 'rails_helper'

RSpec.describe "partidos/new", type: :view do
  before(:each) do
    assign(:partido, Partido.new())
  end

  it "renders new partido form" do
    render

    assert_select "form[action=?][method=?]", partidos_path, "post" do
    end
  end
end
