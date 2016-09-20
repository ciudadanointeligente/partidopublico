require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
    describe "GET index" do

    it "renders the index template" do
      get :index
      expect(response).to render_template("welcome")
    end

  end
end
