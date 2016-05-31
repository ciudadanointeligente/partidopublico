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

class Afiliacion < ActiveRecord::Base
    has_paper_trail
  belongs_to :partido
  
  after_initialize :default_afiliados
  
  def default_afiliados
     self.hombres ||= 0
     self.mujeres ||= 0
  end
  
  def total
     self.hombres + self.mujeres 
  end
end
