require 'rails_helper'

RSpec.describe "Comunas", type: :request do
  describe "GET /partidos/partido_id/regions/region_id/comunas" do
    it "works! (now write some real specs)" do
      partido = create(:partido)
      region = create(:region)

      partido.regions << region
      partido.save

      get partido_region_comunas_path partido_id: partido.id, region_id: region.id
      expect(response).to have_http_status(200)
    end
  end
end
