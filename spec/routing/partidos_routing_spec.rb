require "rails_helper"

RSpec.describe PartidosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/partidos").to route_to("partidos#index")
    end

    it "routes to #new" do
      expect(:get => "/partidos/new").to route_to("partidos#new")
    end

    it "routes to #show" do
      expect(:get => "/partidos/1").to route_to("partidos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/partidos/1/edit").to route_to("partidos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/partidos").to route_to("partidos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/partidos/1").to route_to("partidos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/partidos/1").to route_to("partidos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/partidos/1").to route_to("partidos#destroy", :id => "1")
    end

  end
end
