require "rails_helper"

RSpec.describe IngresoOrdinariosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ingreso_ordinarios").to route_to("ingreso_ordinarios#index")
    end

    it "routes to #new" do
      expect(:get => "/ingreso_ordinarios/new").to route_to("ingreso_ordinarios#new")
    end

    it "routes to #show" do
      expect(:get => "/ingreso_ordinarios/1").to route_to("ingreso_ordinarios#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ingreso_ordinarios/1/edit").to route_to("ingreso_ordinarios#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ingreso_ordinarios").to route_to("ingreso_ordinarios#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ingreso_ordinarios/1").to route_to("ingreso_ordinarios#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ingreso_ordinarios/1").to route_to("ingreso_ordinarios#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ingreso_ordinarios/1").to route_to("ingreso_ordinarios#destroy", :id => "1")
    end

  end
end
