require 'rails_helper'

RSpec.describe "Regions", type: :request do
  describe "GET /partido/:partido_id/regions" do
    it "works! (now write some real specs)" do
      partido = create(:partido)
      get partido_regions_path partido_id: partido.id
      expect(response).to have_http_status(200)
    end
  end
end
