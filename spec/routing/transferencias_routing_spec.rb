require "rails_helper"

RSpec.describe TransferenciasController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/transferencias").to route_to("transferencias#index")
    end

    it "routes to #new" do
      expect(:get => "/transferencias/new").to route_to("transferencias#new")
    end

    it "routes to #show" do
      expect(:get => "/transferencias/1").to route_to("transferencias#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/transferencias/1/edit").to route_to("transferencias#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/transferencias").to route_to("transferencias#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/transferencias/1").to route_to("transferencias#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/transferencias/1").to route_to("transferencias#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/transferencias/1").to route_to("transferencias#destroy", :id => "1")
    end

  end
end
