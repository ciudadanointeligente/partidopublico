require "rails_helper"

RSpec.describe ComunasController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/partidos/1/regions/1/comunas").to route_to("comunas#index", partido_id: '1', region_id: '1')
    end

    it "routes to #new" do
      expect(:get => "/partidos/1/regions/1/comunas/new").to route_to("comunas#new", partido_id: '1', region_id: '1')
    end

    it "routes to #show" do
      expect(:get => "/partidos/1/regions/1/comunas/1").to route_to("comunas#show", :id => "1", partido_id: '1', region_id: '1')
    end

    it "routes to #edit" do
      expect(:get => "/partidos/1/regions/1/comunas/1/edit").to route_to("comunas#edit", :id => "1", partido_id: '1', region_id: '1')
    end

    it "routes to #create" do
      expect(:post => "/partidos/1/regions/1/comunas").to route_to("comunas#create", partido_id: '1', region_id: '1')
    end

    it "routes to #update via PUT" do
      expect(:put => "/partidos/1/regions/1/comunas/1").to route_to("comunas#update", :id => "1", partido_id: '1', region_id: '1')
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/partidos/1/regions/1/comunas/1").to route_to("comunas#update", :id => "1", partido_id: '1', region_id: '1')
    end

    it "routes to #destroy" do
      expect(:delete => "/partidos/1/regions/1/comunas/1").to route_to("comunas#destroy", :id => "1", partido_id: '1', region_id: '1')
    end

  end
end
