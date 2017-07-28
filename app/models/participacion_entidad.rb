# == Schema Information
#
# Table name: participacion_entidads
#
#  id                     :integer          not null, primary key
#  entidad                :string
#  descripcion            :string
#  documento_file_name    :string
#  documento_content_type :string
#  documento_file_size    :integer
#  documento_updated_at   :datetime
#  partido_id             :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  tipo_vinculo           :string
#  fecha_inicio           :string
#  fecha_fin              :string
#  rut                    :string
#  indefinido             :string
#  link                   :string
#
# Indexes
#
#  index_participacion_entidads_on_partido_id  (partido_id)
#

class ParticipacionEntidad < ActiveRecord::Base
    has_paper_trail
    has_attached_file :documento, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/resources/missing.png"
    validates_attachment :documento,
        content_type: { content_type: "application/pdf" },
        size: { in: 0..5000.kilobytes }

    belongs_to :partido


    has_and_belongs_to_many :trimestre_informados


    def self.tipos_vinculo
      %w(Participación Representación Intervención)
    end
end
