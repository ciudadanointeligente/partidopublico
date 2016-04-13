require 'rails_helper'

RSpec.describe FormularioController, type: :controller do

  describe "GET #update_comunas" do
    it "returns http success" do
      get :update_comunas
      expect(response).to have_http_status(:success)
    end
  end

end
