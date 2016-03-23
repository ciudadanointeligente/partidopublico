require "rails_helper"

RSpec.describe LeysController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/leys").to route_to("leys#index")
    end

    it "routes to #new" do
      expect(:get => "/leys/new").to route_to("leys#new")
    end

    it "routes to #show" do
      expect(:get => "/leys/1").to route_to("leys#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/leys/1/edit").to route_to("leys#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/leys").to route_to("leys#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/leys/1").to route_to("leys#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/leys/1").to route_to("leys#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/leys/1").to route_to("leys#destroy", :id => "1")
    end

  end
end
