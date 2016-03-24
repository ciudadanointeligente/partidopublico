require "rails_helper"

RSpec.describe AcuerdosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/acuerdos").to route_to("acuerdos#index")
    end

    it "routes to #new" do
      expect(:get => "/acuerdos/new").to route_to("acuerdos#new")
    end

    it "routes to #show" do
      expect(:get => "/acuerdos/1").to route_to("acuerdos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/acuerdos/1/edit").to route_to("acuerdos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/acuerdos").to route_to("acuerdos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/acuerdos/1").to route_to("acuerdos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/acuerdos/1").to route_to("acuerdos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/acuerdos/1").to route_to("acuerdos#destroy", :id => "1")
    end

  end
end
