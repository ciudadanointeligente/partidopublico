require 'rails_helper'

RSpec.describe "marco_internos/edit", type: :view do
  before(:each) do
    @marco_interno = assign(:marco_interno, MarcoInterno.create!(
      :partido => nil
    ))
  end

  xit "renders the edit marco_interno form" do
    render

    assert_select "form[action=?][method=?]", marco_interno_path(@marco_interno), "post" do

      assert_select "input#marco_interno_partido_id[name=?]", "marco_interno[partido_id]"
    end
  end
end
