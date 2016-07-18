require "rails_helper"

RSpec.describe RegionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/partidos/1/regions").to route_to("regions#index", :partido_id => "1")
    end

    it "routes to #new" do
      expect(:get => "/partidos/1/regions/new").to route_to("regions#new", :partido_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/partidos/1/regions/1").to route_to("regions#show", :partido_id => "1", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/partidos/1/regions/1/edit").to route_to("regions#edit", :partido_id => "1", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/partidos/1/regions").to route_to("regions#create", :partido_id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/partidos/1/regions/1").to route_to("regions#update", :partido_id => "1", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/partidos/1/regions/1").to route_to("regions#update", :partido_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/partidos/1/regions/1").to route_to("regions#destroy", :partido_id => "1", :id => "1")
    end

  end
end
