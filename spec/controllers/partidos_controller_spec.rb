require 'rails_helper'

RSpec.describe PartidosController, type: :controller do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:valid_session) { {} }

  describe "GET #normas_internas" do
    it "get an array of normas internas" do
      partido = create(:partido)
      new_document = create(:documento)
      partido.marco_interno.documentos << new_document
      normas_internas = []
      partido.marco_interno.documentos.each do |d|
        if !d.archivo_file_name.nil?
          normas_internas.push d
        end
      end

      get :normas_internas, {:partido_id => partido.to_param}, valid_session

      expect(assigns(:normas_internas)).to eq(normas_internas)
    end
  end

end
