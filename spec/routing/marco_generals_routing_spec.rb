require "rails_helper"

RSpec.describe MarcoGeneralsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/marco_generals").to route_to("marco_generals#index")
    end

    it "routes to #new" do
      expect(:get => "/marco_generals/new").to route_to("marco_generals#new")
    end

    it "routes to #show" do
      expect(:get => "/marco_generals/1").to route_to("marco_generals#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/marco_generals/1/edit").to route_to("marco_generals#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/marco_generals").to route_to("marco_generals#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/marco_generals/1").to route_to("marco_generals#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/marco_generals/1").to route_to("marco_generals#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/marco_generals/1").to route_to("marco_generals#destroy", :id => "1")
    end

  end
end
