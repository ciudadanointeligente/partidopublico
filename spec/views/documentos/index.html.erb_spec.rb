require 'rails_helper'

RSpec.describe "documentos/index", type: :view do
  before(:each) do
    assign(:documentos, [
      Documento.create!(
        :descripcion => "Descripcion"
      ),
      Documento.create!(
        :descripcion => "Descripcion"
      )
    ])
  end

  it "renders a list of documentos" do
    render
    assert_select "tr>td", :text => "Descripcion".to_s, :count => 2
  end
end
