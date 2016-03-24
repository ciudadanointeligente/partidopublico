# == Schema Information
#
# Table name: leys
#
#  id               :integer          not null, primary key
#  numero           :string
#  nombre           :string
#  enlace           :string
#  tags             :string
#  resumen          :string
#  marco_general_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Ley < ActiveRecord::Base
  belongs_to :marco_general
end
