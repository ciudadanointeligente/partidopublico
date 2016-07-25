require 'rails_helper'

RSpec.describe "EgresoOrdinarios", type: :request do
  describe "GET /egreso_ordinarios" do
    it "works! (now write some real specs)" do
      get egreso_ordinarios_path
      expect(response).to have_http_status(200)
    end
  end
end
