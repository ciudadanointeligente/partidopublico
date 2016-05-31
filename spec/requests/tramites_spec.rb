require 'rails_helper'

RSpec.describe "Tramites", type: :request do
  describe "GET /tramites" do
    it "works! (now write some real specs)" do
      get tramites_path
      expect(response).to have_http_status(200)
    end
  end
end
