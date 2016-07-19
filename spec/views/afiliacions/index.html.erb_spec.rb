require 'rails_helper'

RSpec.describe "afiliacions/index", type: :view do
  before(:each) do
    assign(:afiliacions, [
      Afiliacion.create!(
        :region => nil,
        :hombres => 1,
        :mujeres => 2,
        :otros => 1,
        :fecha_datos => '2016-01-01'
      ),
      Afiliacion.create!(
        :region => nil,
        :hombres => 1,
        :mujeres => 2,
        :otros => 1,
        :fecha_datos => '2016-01-01'
      )
    ])
  end

  it "renders a list of afiliacions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
