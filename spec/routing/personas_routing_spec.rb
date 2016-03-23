require "rails_helper"

RSpec.describe PersonasController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/personas").to route_to("personas#index")
    end

    it "routes to #new" do
      expect(:get => "/personas/new").to route_to("personas#new")
    end

    it "routes to #show" do
      expect(:get => "/personas/1").to route_to("personas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/personas/1/edit").to route_to("personas#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/personas").to route_to("personas#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/personas/1").to route_to("personas#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/personas/1").to route_to("personas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/personas/1").to route_to("personas#destroy", :id => "1")
    end

  end
end
