require 'rails_helper'

RSpec.describe "IngresoOrdinarios", type: :request do
  describe "GET /ingreso_ordinarios" do
    it "works! (now write some real specs)" do
      get ingreso_ordinarios_path
      expect(response).to have_http_status(200)
    end
  end
end
