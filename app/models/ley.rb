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
# Indexes
#
#  index_leys_on_marco_general_id  (marco_general_id)
#

class Ley < ActiveRecord::Base
    # has_paper_trail
  belongs_to :marco_general
end
