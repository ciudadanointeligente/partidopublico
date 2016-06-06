require 'rails_helper'

RSpec.describe "distritos/new", type: :view do
  before(:each) do
    assign(:distrito, Distrito.new())
  end

  it "renders new distrito form" do
    render

    assert_select "form[action=?][method=?]", distritos_path, "post" do
    end
  end
end
