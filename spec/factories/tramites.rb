# == Schema Information
#
# Table name: tramites
#
#  id                     :integer          not null, primary key
#  nombre                 :string
#  descripcion            :string
#  persona_id             :integer
#  documento_file_name    :string
#  documento_content_type :string
#  documento_file_size    :integer
#  documento_updated_at   :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  partido_id             :integer
#
# Indexes
#
#  index_tramites_on_partido_id  (partido_id)
#  index_tramites_on_persona_id  (persona_id)
#

FactoryGirl.define do
  factory :tramite do
    nombre "MyString"
    descripcion "MyString"
    persona nil
  end
end
