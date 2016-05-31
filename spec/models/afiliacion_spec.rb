# == Schema Information
#
# Table name: afiliacions
#
#  id         :integer          not null, primary key
#  hombres    :integer
#  mujeres    :integer
#  rangos     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  partido_id :integer
#  region     :string
#
# Indexes
#
#  index_afiliacions_on_partido_id  (partido_id)
#

require 'rails_helper'

RSpec.describe Afiliacion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
