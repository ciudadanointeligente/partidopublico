require "rails_helper"

RSpec.describe IngresoCampanasController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ingreso_campanas").to route_to("ingreso_campanas#index")
    end

    it "routes to #new" do
      expect(:get => "/ingreso_campanas/new").to route_to("ingreso_campanas#new")
    end

    it "routes to #show" do
      expect(:get => "/ingreso_campanas/1").to route_to("ingreso_campanas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ingreso_campanas/1/edit").to route_to("ingreso_campanas#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ingreso_campanas").to route_to("ingreso_campanas#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ingreso_campanas/1").to route_to("ingreso_campanas#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ingreso_campanas/1").to route_to("ingreso_campanas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ingreso_campanas/1").to route_to("ingreso_campanas#destroy", :id => "1")
    end

  end
end
