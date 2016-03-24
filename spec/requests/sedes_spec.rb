require 'rails_helper'

RSpec.describe "Sedes", type: :request do
  describe "GET /sedes" do
    it "works! (now write some real specs)" do
      get sedes_path
      expect(response).to have_http_status(200)
    end
  end
end
