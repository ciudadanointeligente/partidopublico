require 'rails_helper'

RSpec.describe "Comunas", type: :request do
  describe "GET /comunas" do
    it "works! (now write some real specs)" do
      get comunas_path
      expect(response).to have_http_status(200)
    end
  end
end
