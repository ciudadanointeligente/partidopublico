# == Schema Information
#
# Table name: trimestre_informados
#
#  id         :integer          not null, primary key
#  ano        :integer
#  trimestre  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TrimestreInformado < ActiveRecord::Base
  has_and_belongs_to_many :sedes
end
