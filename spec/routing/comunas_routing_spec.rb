require "rails_helper"

RSpec.describe ComunasController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/comunas").to route_to("comunas#index")
    end

    it "routes to #new" do
      expect(:get => "/comunas/new").to route_to("comunas#new")
    end

    it "routes to #show" do
      expect(:get => "/comunas/1").to route_to("comunas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/comunas/1/edit").to route_to("comunas#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/comunas").to route_to("comunas#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/comunas/1").to route_to("comunas#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/comunas/1").to route_to("comunas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/comunas/1").to route_to("comunas#destroy", :id => "1")
    end

  end
end
