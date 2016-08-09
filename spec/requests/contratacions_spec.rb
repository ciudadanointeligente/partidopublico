require 'rails_helper'

RSpec.describe "Contratacions", type: :request do
  describe "GET /contratacions" do
    it "works! (now write some real specs)" do
      get contratacions_path
      expect(response).to have_http_status(200)
    end
  end
end
