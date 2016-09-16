require 'rails_helper'

RSpec.describe "actividad_publicas/index", type: :view do
  before(:each) do
    assign(:actividad_publicas, [
      ActividadPublica.create!(),
      ActividadPublica.create!()
    ])
  end

  xit "renders a list of actividad_publicas" do
    render
  end
end
