# == Schema Information
#
# Table name: sancions
#
#  id                     :integer          not null, primary key
#  descripcion            :string
#  institucion            :string
#  fecha                  :date
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
#  index_sancions_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :sancion do
    descripcion "MyString"
    institucion "MyString"
    fecha "2016-05-18"
  end
end
