# == Schema Information
#
# Table name: trimestre_informados
#
#  id         :integer          not null, primary key
#  ano        :integer
#  trimestre  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ordinal    :integer
#

class TrimestreInformado < ActiveRecord::Base
  has_and_belongs_to_many :sedes
  has_and_belongs_to_many :organo_internos
  has_and_belongs_to_many :cargos
  has_and_belongs_to_many :egreso_ordinarios
  has_and_belongs_to_many :ingreso_ordinarios
  has_and_belongs_to_many :transferencias
  has_and_belongs_to_many :contratacions
  has_and_belongs_to_many :egreso_campanas
  has_and_belongs_to_many :ingreso_campanas
  has_and_belongs_to_many :afiliacions
  has_and_belongs_to_many :sancions
  validates_presence_of :ordinal

  def to_s
    self.ano.to_s + ' ' + self.trimestre.to_s
  end

end
