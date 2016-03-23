require "rails_helper"

RSpec.describe EleccionPopularsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/eleccion_populars").to route_to("eleccion_populars#index")
    end

    it "routes to #new" do
      expect(:get => "/eleccion_populars/new").to route_to("eleccion_populars#new")
    end

    it "routes to #show" do
      expect(:get => "/eleccion_populars/1").to route_to("eleccion_populars#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/eleccion_populars/1/edit").to route_to("eleccion_populars#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/eleccion_populars").to route_to("eleccion_populars#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/eleccion_populars/1").to route_to("eleccion_populars#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/eleccion_populars/1").to route_to("eleccion_populars#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/eleccion_populars/1").to route_to("eleccion_populars#destroy", :id => "1")
    end

  end
end
