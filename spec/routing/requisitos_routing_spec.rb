require "rails_helper"

RSpec.describe RequisitosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/requisitos").to route_to("requisitos#index")
    end

    it "routes to #new" do
      expect(:get => "/requisitos/new").to route_to("requisitos#new")
    end

    it "routes to #show" do
      expect(:get => "/requisitos/1").to route_to("requisitos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/requisitos/1/edit").to route_to("requisitos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/requisitos").to route_to("requisitos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/requisitos/1").to route_to("requisitos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/requisitos/1").to route_to("requisitos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/requisitos/1").to route_to("requisitos#destroy", :id => "1")
    end

  end
end
