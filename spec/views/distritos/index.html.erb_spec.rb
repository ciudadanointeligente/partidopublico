require 'rails_helper'

RSpec.describe "distritos/index", type: :view do
  before(:each) do
    assign(:distritos, [
      Distrito.create!(),
      Distrito.create!()
    ])
  end

  it "renders a list of distritos" do
    render
  end
end
