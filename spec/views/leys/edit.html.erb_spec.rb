require 'rails_helper'

RSpec.describe "leys/edit", type: :view do
  before(:each) do
    # @ley = assign(:ley, Ley.create!(
    #   :numero => "MyString",
    #   :nombre => "MyString",
    #   :enlace => "MyString",
    #   :tags => "MyString",
    #   :resumen => "MyString",
    #   :marco_general => nil
    # ))
    @ley = create(:ley)
  end

  xit "renders the edit ley form" do
    render

    assert_select "form[action=?][method=?]", ley_path(@ley), "post" do

      assert_select "input#ley_numero[name=?]", "ley[numero]"

      assert_select "input#ley_nombre[name=?]", "ley[nombre]"

      assert_select "input#ley_enlace[name=?]", "ley[enlace]"

      assert_select "input#ley_tags[name=?]", "ley[tags]"

      assert_select "input#ley_resumen[name=?]", "ley[resumen]"

      assert_select "input#ley_marco_general_id[name=?]", "ley[marco_general_id]"
    end
  end
end
