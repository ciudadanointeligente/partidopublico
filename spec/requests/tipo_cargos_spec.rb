require 'rails_helper'

RSpec.describe "TipoCargos", type: :request do
  describe "GET /tipo_cargos" do
    it "works! (now write some real specs)" do
      partido = FactoryGirl.create(:partido)
      get tipo_cargos_path , {:partido_id => partido.id}
      expect(response).to have_http_status(200)
    end
  end
end
