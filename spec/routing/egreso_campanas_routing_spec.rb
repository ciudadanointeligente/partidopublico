require "rails_helper"

RSpec.describe EgresoCampanasController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/egreso_campanas").to route_to("egreso_campanas#index")
    end

    it "routes to #new" do
      expect(:get => "/egreso_campanas/new").to route_to("egreso_campanas#new")
    end

    it "routes to #show" do
      expect(:get => "/egreso_campanas/1").to route_to("egreso_campanas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/egreso_campanas/1/edit").to route_to("egreso_campanas#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/egreso_campanas").to route_to("egreso_campanas#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/egreso_campanas/1").to route_to("egreso_campanas#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/egreso_campanas/1").to route_to("egreso_campanas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/egreso_campanas/1").to route_to("egreso_campanas#destroy", :id => "1")
    end

  end
end
