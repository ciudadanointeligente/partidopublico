require 'rails_helper'

RSpec.describe "Regions", type: :request do
  describe "GET /regions" do
    it "works! (now write some real specs)" do
      get regions_path
      expect(response).to have_http_status(200)
    end
  end
end
