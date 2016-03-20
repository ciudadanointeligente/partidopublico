require 'rails_helper'

RSpec.describe "partidos/edit", type: :view do
  before(:each) do
    # @partido = assign(:partido, Partido.create!())
    @partido = FactoryGirl.create(:partido)
  end

  it "renders the edit partido form" do
    render

    assert_select "form[action=?][method=?]", partido_path(@partido), "post" do
    end
  end
end
