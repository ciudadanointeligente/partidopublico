require 'rails_helper'

RSpec.describe Partido, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
  
  describe "model validations" do
      it "has a valid factory" do
        FactoryGirl.create(:partido).should be_valid
        # raise "this is the failure"
      end
  end
  
end
