require "rails_helper"

RSpec.describe EgresoOrdinariosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/egreso_ordinarios").to route_to("egreso_ordinarios#index")
    end

    it "routes to #new" do
      expect(:get => "/egreso_ordinarios/new").to route_to("egreso_ordinarios#new")
    end

    it "routes to #show" do
      expect(:get => "/egreso_ordinarios/1").to route_to("egreso_ordinarios#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/egreso_ordinarios/1/edit").to route_to("egreso_ordinarios#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/egreso_ordinarios").to route_to("egreso_ordinarios#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/egreso_ordinarios/1").to route_to("egreso_ordinarios#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/egreso_ordinarios/1").to route_to("egreso_ordinarios#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/egreso_ordinarios/1").to route_to("egreso_ordinarios#destroy", :id => "1")
    end

  end
end
