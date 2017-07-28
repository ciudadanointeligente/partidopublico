# == Schema Information
#
# Table name: acuerdos
#
#  id                     :integer          not null, primary key
#  numero                 :string
#  fecha                  :string
#  tipo                   :string
#  tema                   :string
#  region                 :string
#  organo_interno_id      :integer
#  documento_file_name    :string
#  documento_content_type :string
#  documento_file_size    :integer
#  documento_updated_at   :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  partido_id             :integer
#  materia                :string
#  nombre_organo          :string
#  denominacion           :string
#  descripcion            :string
#  link                   :string
#
# Indexes
#
#  index_acuerdos_on_organo_interno_id  (organo_interno_id)
#  index_acuerdos_on_partido_id         (partido_id)
#

class Acuerdo < ActiveRecord::Base
    has_paper_trail
    has_attached_file :documento, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/resources/missing.png"
    validates_attachment :documento,
        content_type: { content_type: "application/pdf" },
        size: { in: 0..5000.kilobytes }

    belongs_to :partido
    belongs_to :organo_interno

    has_and_belongs_to_many :trimestre_informados

    def self.tipos
      %w(Acta Programatico Electoral Funcionamiento\ Interno)
    end
end
