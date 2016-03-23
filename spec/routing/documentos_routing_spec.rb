require "rails_helper"

RSpec.describe DocumentosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/documentos").to route_to("documentos#index")
    end

    it "routes to #new" do
      expect(:get => "/documentos/new").to route_to("documentos#new")
    end

    it "routes to #show" do
      expect(:get => "/documentos/1").to route_to("documentos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/documentos/1/edit").to route_to("documentos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/documentos").to route_to("documentos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/documentos/1").to route_to("documentos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/documentos/1").to route_to("documentos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/documentos/1").to route_to("documentos#destroy", :id => "1")
    end

  end
end
