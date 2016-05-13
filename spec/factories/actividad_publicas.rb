# == Schema Information
#
# Table name: actividad_publicas
#
#  id          :integer          not null, primary key
#  fecha       :date
#  descripcion :string
#  link        :string
#  lugar       :string
#  partido_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_actividad_publicas_on_partido_id  (partido_id)
#

FactoryGirl.define do
  factory :actividad_publica do
    fecha "2016-05-10"
    descripcion "MyString"
    link "MyString"
  end
end
