require 'rails_helper'

RSpec.describe "EgresoOrdinarios", type: :request do
  describe "GET /egreso_ordinarios" do
    xit "works! (now write some real specs)" do
      partido = FactoryGirl.create(:partido)
      get egreso_ordinarios_path, {:partido_id => partido.id}
      expect(response).to have_http_status(200)
    end
  end
end
