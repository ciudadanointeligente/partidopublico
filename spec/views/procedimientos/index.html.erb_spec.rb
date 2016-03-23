require 'rails_helper'

RSpec.describe "procedimientos/index", type: :view do
  before(:each) do
    assign(:procedimientos, [
      Procedimiento.create!(
        :descripcion => "Descripcion"
      ),
      Procedimiento.create!(
        :descripcion => "Descripcion"
      )
    ])
  end

  it "renders a list of procedimientos" do
    render
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
  end
end
