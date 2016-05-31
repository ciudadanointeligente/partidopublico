# == Schema Information
#
# Table name: participacion_entidads
#
#  id                     :integer          not null, primary key
#  entidad                :string
#  descripcion            :string
#  documento_file_name    :string
#  documento_content_type :string
#  documento_file_size    :integer
#  documento_updated_at   :datetime
#  partido_id             :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_participacion_entidads_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :participacion_entidad do
    
  end
end
