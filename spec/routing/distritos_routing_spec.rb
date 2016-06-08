require "rails_helper"

RSpec.describe DistritosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/distritos").to route_to("distritos#index")
    end

    it "routes to #new" do
      expect(:get => "/distritos/new").to route_to("distritos#new")
    end

    it "routes to #show" do
      expect(:get => "/distritos/1").to route_to("distritos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/distritos/1/edit").to route_to("distritos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/distritos").to route_to("distritos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/distritos/1").to route_to("distritos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/distritos/1").to route_to("distritos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/distritos/1").to route_to("distritos#destroy", :id => "1")
    end

  end
end
