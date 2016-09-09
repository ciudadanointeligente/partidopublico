# == Schema Information
#
# Table name: partidos
#
#  id                :integer          not null, primary key
#  nombre            :string           not null
#  sigla             :string           not null
#  lema              :string           not null
#  fecha_fundacion   :date
#  texto             :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  user_id           :integer
#
# Indexes
#
#  index_partidos_on_user_id  (user_id)
#

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
