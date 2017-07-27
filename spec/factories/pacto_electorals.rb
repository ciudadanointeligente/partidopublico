# == Schema Information
#
# Table name: pacto_electorals
#
#  id           :integer          not null, primary key
#  ano_eleccion :integer
#  nombre_pacto :string
#  descripcion  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  partido_id   :integer
#  tipo         :string
#
# Indexes
#
#  index_pacto_electorals_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :pacto_electoral do
    
  end
end
