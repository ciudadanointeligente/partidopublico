require "rails_helper"

RSpec.describe EleccionInternasController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/eleccion_internas").to route_to("eleccion_internas#index")
    end

    it "routes to #new" do
      expect(:get => "/eleccion_internas/new").to route_to("eleccion_internas#new")
    end

    it "routes to #show" do
      expect(:get => "/eleccion_internas/1").to route_to("eleccion_internas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/eleccion_internas/1/edit").to route_to("eleccion_internas#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/eleccion_internas").to route_to("eleccion_internas#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/eleccion_internas/1").to route_to("eleccion_internas#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/eleccion_internas/1").to route_to("eleccion_internas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/eleccion_internas/1").to route_to("eleccion_internas#destroy", :id => "1")
    end

  end
end
