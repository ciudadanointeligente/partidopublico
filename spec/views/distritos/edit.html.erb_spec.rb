require 'rails_helper'

RSpec.describe "distritos/edit", type: :view do
  before(:each) do
    @distrito = assign(:distrito, Distrito.create!())
  end

  it "renders the edit distrito form" do
    render

    assert_select "form[action=?][method=?]", distrito_path(@distrito), "post" do
    end
  end
end
