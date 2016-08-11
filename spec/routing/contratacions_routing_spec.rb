require "rails_helper"

RSpec.describe ContratacionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/contratacions").to route_to("contratacions#index")
    end

    it "routes to #new" do
      expect(:get => "/contratacions/new").to route_to("contratacions#new")
    end

    it "routes to #show" do
      expect(:get => "/contratacions/1").to route_to("contratacions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/contratacions/1/edit").to route_to("contratacions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/contratacions").to route_to("contratacions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/contratacions/1").to route_to("contratacions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/contratacions/1").to route_to("contratacions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/contratacions/1").to route_to("contratacions#destroy", :id => "1")
    end

  end
end
