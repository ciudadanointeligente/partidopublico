# == Schema Information
#
# Table name: categoria_financieras
#
#  id           :integer          not null, primary key
#  partido_id   :integer
#  documento_id :integer
#  fecha        :date
#  titulo       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :categoria_financiera do
    partido_id 1
    fecha "2016-06-10"
    titulo "MyString"
  end
end
