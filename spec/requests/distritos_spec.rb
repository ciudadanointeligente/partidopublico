require 'rails_helper'

RSpec.describe "Distritos", type: :request do
  describe "GET /distritos" do
    it "works! (now write some real specs)" do
      get distritos_path
      expect(response).to have_http_status(200)
    end
  end
end
