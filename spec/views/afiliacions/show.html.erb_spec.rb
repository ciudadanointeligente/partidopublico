require 'rails_helper'

RSpec.describe "afiliacions/show", type: :view do
  before(:each) do
    partido = create(:partido)
    region = create(:region)
    @afiliacion = assign(:afiliacion, Afiliacion.create!(
      :partido => partido,
      :region => region,
      :hombres => 1,
      :mujeres => 2,
      :otros => 1,
      :fecha_datos => '2016-01-01',
      :ano_nacimiento => 1971
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
