require 'rails_helper'

RSpec.describe "actividad_publicas/show", type: :view do
  before(:each) do
    @actividad_publica = assign(:actividad_publica, ActividadPublica.create!())
  end

  xit "renders attributes in <p>" do
    render
  end
end
