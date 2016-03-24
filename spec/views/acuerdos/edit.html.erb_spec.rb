require 'rails_helper'

RSpec.describe "acuerdos/edit", type: :view do
  before(:each) do
    @acuerdo = assign(:acuerdo, Acuerdo.create!(
      :numero => "MyString",
      :tipo => "MyString",
      :tema => "MyString",
      :region => "MyString",
      :organo_interno => nil
    ))
  end

  xit "renders the edit acuerdo form" do
    render

    assert_select "form[action=?][method=?]", acuerdo_path(@acuerdo), "post" do

      assert_select "input#acuerdo_numero[name=?]", "acuerdo[numero]"

      assert_select "input#acuerdo_tipo[name=?]", "acuerdo[tipo]"

      assert_select "input#acuerdo_tema[name=?]", "acuerdo[tema]"

      assert_select "input#acuerdo_region[name=?]", "acuerdo[region]"

      assert_select "input#acuerdo_organo_interno_id[name=?]", "acuerdo[organo_interno_id]"
    end
  end
end
