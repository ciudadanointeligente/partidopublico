require 'rails_helper'

RSpec.describe "afiliacions/index", type: :view do
  before(:each) do
    partido = create(:partido)
    region = create(:region)
    assign(:afiliacions, [
      Afiliacion.create!(
        :partido => partido,
        :region => region,
        :hombres => 1,
        :mujeres => 2,
        :otros => 1,
        :fecha_datos => '2016-01-01',
        :ano_nacimiento => 1971
      ),
      Afiliacion.create!(
        :partido => partido,
        :region => region,
        :hombres => 1,
        :mujeres => 2,
        :otros => 1,
        :fecha_datos => '2016-01-01',
        :ano_nacimiento => 1970
      )
    ])
  end

  it "renders a list of afiliacions" do
    render
    assert_select "tr>td", :text => 1971.to_s, :count => 1
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
