require 'rails_helper'

RSpec.describe "ActividadPublicas", type: :request do
  describe "GET /actividad_publicas" do
    it "works! (now write some real specs)" do
      get actividad_publicas_path
      expect(response).to have_http_status(200)
    end
  end
end
