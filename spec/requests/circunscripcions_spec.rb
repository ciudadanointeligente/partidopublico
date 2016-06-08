require 'rails_helper'

RSpec.describe "Circunscripcions", type: :request do
  describe "GET /circunscripcions" do
    it "works! (now write some real specs)" do
      get circunscripcions_path
      expect(response).to have_http_status(200)
    end
  end
end
