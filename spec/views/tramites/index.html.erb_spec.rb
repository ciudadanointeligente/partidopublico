require 'rails_helper'

RSpec.describe "tramites/index", type: :view do
  before(:each) do
    assign(:tramites, [
      Tramite.create!(
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :persona => nil
      ),
      Tramite.create!(
        :nombre => "Nombre",
        :descripcion => "Descripcion",
        :persona => nil
      )
    ])
  end

  it "renders a list of tramites" do
    render
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
