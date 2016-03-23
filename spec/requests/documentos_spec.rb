require 'rails_helper'

RSpec.describe "Documentos", type: :request do
  describe "GET /documentos" do
    xit "works! (now write some real specs)" do
      get documentos_path
      expect(response).to have_http_status(200)
    end
  end
end
