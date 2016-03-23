require "rails_helper"

RSpec.describe MarcoInternosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/marco_internos").to route_to("marco_internos#index")
    end

    it "routes to #new" do
      expect(:get => "/marco_internos/new").to route_to("marco_internos#new")
    end

    it "routes to #show" do
      expect(:get => "/marco_internos/1").to route_to("marco_internos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/marco_internos/1/edit").to route_to("marco_internos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/marco_internos").to route_to("marco_internos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/marco_internos/1").to route_to("marco_internos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/marco_internos/1").to route_to("marco_internos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/marco_internos/1").to route_to("marco_internos#destroy", :id => "1")
    end

  end
end
