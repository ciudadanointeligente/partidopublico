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

class CategoriaFinanciera < ActiveRecord::Base
  has_many :item_contables
  belongs_to :partido
  belongs_to :documento
end
