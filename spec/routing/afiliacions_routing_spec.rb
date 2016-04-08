require "rails_helper"

RSpec.describe AfiliacionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/afiliacions").to route_to("afiliacions#index")
    end

    it "routes to #new" do
      expect(:get => "/afiliacions/new").to route_to("afiliacions#new")
    end

    it "routes to #show" do
      expect(:get => "/afiliacions/1").to route_to("afiliacions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/afiliacions/1/edit").to route_to("afiliacions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/afiliacions").to route_to("afiliacions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/afiliacions/1").to route_to("afiliacions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/afiliacions/1").to route_to("afiliacions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/afiliacions/1").to route_to("afiliacions#destroy", :id => "1")
    end

  end
end
