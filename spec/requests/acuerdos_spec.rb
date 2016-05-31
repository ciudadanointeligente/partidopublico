require 'rails_helper'

RSpec.describe "Acuerdos", type: :request do
  describe "GET /acuerdos" do
    it "works! (now write some real specs)" do
      get acuerdos_path
      expect(response).to have_http_status(200)
    end
  end
end
