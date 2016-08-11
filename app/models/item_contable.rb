# == Schema Information
#
# Table name: item_contables
#
#  id                      :integer          not null, primary key
#  categoria_financiera_id :integer
#  concepto                :string
#  dinero_publico          :boolean
#  importe                 :integer
#  partido_id              :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  fecha_datos             :date
#

class ItemContable < ActiveRecord::Base
  belongs_to :partido_id
  belongs_to :categoria_financiera

  validates_presence_of :concepto, :importe, :categoria_financiera
end
