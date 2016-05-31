require 'rails_helper'

RSpec.describe "acuerdos/index", type: :view do
  before(:each) do
    assign(:acuerdos, [
      Acuerdo.create!(
        :numero => "Numero",
        :tipo => "Tipo",
        :tema => "Tema",
        :region => "Region",
        :organo_interno => nil
      ),
      Acuerdo.create!(
        :numero => "Numero",
        :tipo => "Tipo",
        :tema => "Tema",
        :region => "Region",
        :organo_interno => nil
      )
    ])
  end

  xit "renders a list of acuerdos" do
    render
    assert_select "tr>td", :text => "Numero".to_s, :count => 2
    assert_select "tr>td", :text => "Tipo".to_s, :count => 2
    assert_select "tr>td", :text => "Tema".to_s, :count => 2
    assert_select "tr>td", :text => "Region".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
