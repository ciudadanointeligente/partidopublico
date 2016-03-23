require "rails_helper"

RSpec.describe ProcedimientosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/procedimientos").to route_to("procedimientos#index")
    end

    it "routes to #new" do
      expect(:get => "/procedimientos/new").to route_to("procedimientos#new")
    end

    it "routes to #show" do
      expect(:get => "/procedimientos/1").to route_to("procedimientos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/procedimientos/1/edit").to route_to("procedimientos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/procedimientos").to route_to("procedimientos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/procedimientos/1").to route_to("procedimientos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/procedimientos/1").to route_to("procedimientos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/procedimientos/1").to route_to("procedimientos#destroy", :id => "1")
    end

  end
end
