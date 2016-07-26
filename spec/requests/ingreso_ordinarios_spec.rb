require 'rails_helper'

RSpec.describe "IngresoOrdinarios", type: :request do
  describe "GET /ingreso_ordinarios" do
    xit "works! (now write some real specs)" do
      partido = FactoryGirl.create(:partido)
      get ingreso_ordinarios_path, {:partido_id => partido.id}
      expect(response).to have_http_status(200)
    end
  end
end
