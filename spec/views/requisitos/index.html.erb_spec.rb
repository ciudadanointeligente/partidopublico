require 'rails_helper'

RSpec.describe "requisitos/index", type: :view do
  before(:each) do
    assign(:requisitos, [
      Requisito.create!(
        :descripcion => "Descripcion"
      ),
      Requisito.create!(
        :descripcion => "Descripcion"
      )
    ])
  end

  it "renders a list of requisitos" do
    render
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
  end
end
