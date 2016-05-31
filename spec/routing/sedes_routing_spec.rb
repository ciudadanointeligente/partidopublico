require "rails_helper"

RSpec.describe SedesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sedes").to route_to("sedes#index")
    end

    it "routes to #new" do
      expect(:get => "/sedes/new").to route_to("sedes#new")
    end

    it "routes to #show" do
      expect(:get => "/sedes/1").to route_to("sedes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sedes/1/edit").to route_to("sedes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sedes").to route_to("sedes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sedes/1").to route_to("sedes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sedes/1").to route_to("sedes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sedes/1").to route_to("sedes#destroy", :id => "1")
    end

  end
end
