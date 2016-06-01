require "rails_helper"

RSpec.describe TipoCargosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/tipo_cargos").to route_to("tipo_cargos#index")
    end

    it "routes to #new" do
      expect(:get => "/tipo_cargos/new").to route_to("tipo_cargos#new")
    end

    it "routes to #show" do
      expect(:get => "/tipo_cargos/1").to route_to("tipo_cargos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/tipo_cargos/1/edit").to route_to("tipo_cargos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/tipo_cargos").to route_to("tipo_cargos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tipo_cargos/1").to route_to("tipo_cargos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tipo_cargos/1").to route_to("tipo_cargos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tipo_cargos/1").to route_to("tipo_cargos#destroy", :id => "1")
    end

  end
end
