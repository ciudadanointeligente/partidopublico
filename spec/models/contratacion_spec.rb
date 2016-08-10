# == Schema Information
#
# Table name: contratacions
#
#  id                :integer          not null, primary key
#  partido_id        :integer
#  fecha_datos       :date
#  numero            :string
#  individualizacion :string
#  razon_social      :string
#  rut               :string
#  titulares         :string
#  descripcion       :string
#  monto             :integer
#  fecha_inicio      :date
#  fecha_termino     :date
#  link              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_contratacions_on_partido_id  (partido_id)
#

require 'rails_helper'

RSpec.describe Contratacion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
