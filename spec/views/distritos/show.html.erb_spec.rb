require 'rails_helper'

RSpec.describe "distritos/show", type: :view do
  before(:each) do
    @distrito = assign(:distrito, Distrito.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
