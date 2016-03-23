require 'rails_helper'

RSpec.describe "Personas", type: :request do
  describe "GET /personas" do
    xit "works! (now write some real specs)" do
      get personas_path
      expect(response).to have_http_status(200)
    end
  end
end
