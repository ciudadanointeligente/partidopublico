require "rails_helper"

RSpec.describe CircunscripcionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/circunscripcions").to route_to("circunscripcions#index")
    end

    it "routes to #new" do
      expect(:get => "/circunscripcions/new").to route_to("circunscripcions#new")
    end

    it "routes to #show" do
      expect(:get => "/circunscripcions/1").to route_to("circunscripcions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/circunscripcions/1/edit").to route_to("circunscripcions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/circunscripcions").to route_to("circunscripcions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/circunscripcions/1").to route_to("circunscripcions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/circunscripcions/1").to route_to("circunscripcions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/circunscripcions/1").to route_to("circunscripcions#destroy", :id => "1")
    end

  end
end
