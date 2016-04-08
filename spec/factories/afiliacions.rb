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

FactoryGirl.define do
  factory :afiliacion do
    region nil
    hombres 1
    mujeres 1
    rangos "MyString"
  end
end
