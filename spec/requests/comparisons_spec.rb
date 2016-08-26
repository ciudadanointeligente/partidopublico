require 'rails_helper'

RSpec.describe "Comparisons", type: :request do
  describe "GET /comparisons" do
    it "works! (now write some real specs)" do
      get comparisons_path
      expect(response).to have_http_status(200)
    end
  end
end
