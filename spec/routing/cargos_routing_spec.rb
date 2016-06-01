require "rails_helper"

RSpec.describe CargosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cargos").to route_to("cargos#index")
    end

    it "routes to #new" do
      expect(:get => "/cargos/new").to route_to("cargos#new")
    end

    it "routes to #show" do
      expect(:get => "/cargos/1").to route_to("cargos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cargos/1/edit").to route_to("cargos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cargos").to route_to("cargos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cargos/1").to route_to("cargos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cargos/1").to route_to("cargos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cargos/1").to route_to("cargos#destroy", :id => "1")
    end

  end
end
