require "rails_helper"

RSpec.describe TramitesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/tramites").to route_to("tramites#index")
    end

    it "routes to #new" do
      expect(:get => "/tramites/new").to route_to("tramites#new")
    end

    it "routes to #show" do
      expect(:get => "/tramites/1").to route_to("tramites#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/tramites/1/edit").to route_to("tramites#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/tramites").to route_to("tramites#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tramites/1").to route_to("tramites#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tramites/1").to route_to("tramites#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tramites/1").to route_to("tramites#destroy", :id => "1")
    end

  end
end
