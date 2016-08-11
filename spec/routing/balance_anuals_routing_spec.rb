require "rails_helper"

RSpec.describe BalanceAnualsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/balance_anuals").to route_to("balance_anuals#index")
    end

    it "routes to #new" do
      expect(:get => "/balance_anuals/new").to route_to("balance_anuals#new")
    end

    it "routes to #show" do
      expect(:get => "/balance_anuals/1").to route_to("balance_anuals#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/balance_anuals/1/edit").to route_to("balance_anuals#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/balance_anuals").to route_to("balance_anuals#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/balance_anuals/1").to route_to("balance_anuals#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/balance_anuals/1").to route_to("balance_anuals#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/balance_anuals/1").to route_to("balance_anuals#destroy", :id => "1")
    end

  end
end
