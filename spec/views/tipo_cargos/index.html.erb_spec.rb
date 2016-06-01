require 'rails_helper'

RSpec.describe "tipo_cargos/index", type: :view do
  before(:each) do
    assign(:tipo_cargos, [
      TipoCargo.create!(
        :titulo => "Titulo"
      ),
      TipoCargo.create!(
        :titulo => "Titulo"
      )
    ])
  end

  it "renders a list of tipo_cargos" do
    render
    assert_select "tr>td", :text => "Titulo".to_s, :count => 2
  end
end
