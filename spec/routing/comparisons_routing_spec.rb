require "rails_helper"

RSpec.describe ComparisonsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/comparisons").to route_to("comparisons#index")
    end

    it "routes to #new" do
      expect(:get => "/comparisons/new").to route_to("comparisons#new")
    end

    it "routes to #show" do
      expect(:get => "/comparisons/1").to route_to("comparisons#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/comparisons/1/edit").to route_to("comparisons#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/comparisons").to route_to("comparisons#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/comparisons/1").to route_to("comparisons#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/comparisons/1").to route_to("comparisons#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/comparisons/1").to route_to("comparisons#destroy", :id => "1")
    end

  end
end
