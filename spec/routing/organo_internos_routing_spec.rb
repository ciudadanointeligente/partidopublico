require "rails_helper"

RSpec.describe OrganoInternosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/organo_internos").to route_to("organo_internos#index")
    end

    it "routes to #new" do
      expect(:get => "/organo_internos/new").to route_to("organo_internos#new")
    end

    it "routes to #show" do
      expect(:get => "/organo_internos/1").to route_to("organo_internos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/organo_internos/1/edit").to route_to("organo_internos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/organo_internos").to route_to("organo_internos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/organo_internos/1").to route_to("organo_internos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/organo_internos/1").to route_to("organo_internos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/organo_internos/1").to route_to("organo_internos#destroy", :id => "1")
    end

  end
end
