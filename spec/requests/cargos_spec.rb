require 'rails_helper'

RSpec.describe "Cargos", type: :request do
  describe "GET /cargos" do
    it "obtiene los cargos" do
        partido = FactoryGirl.create(:partido)
        get cargos_path , {:partido_id => partido.id}
        expect(response).to have_http_status(200)
    end
  end
end
