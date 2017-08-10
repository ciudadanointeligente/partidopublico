# == Schema Information
#
# Table name: sancions
#
#  id                     :integer          not null, primary key
#  descripcion            :string
#  institucion            :string
#  fecha                  :date
#  documento_file_name    :string
#  documento_content_type :string
#  documento_file_size    :integer
#  documento_updated_at   :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  partido_id             :integer
#  tipo_sancion           :string
#  tipo_infraccion        :string
#  link_resolucion        :string
#
# Indexes
#
#  index_sancions_on_partido_id  (partido_id)
#

class Sancion < ActiveRecord::Base
    # has_paper_trail

    has_and_belongs_to_many :trimestre_informados

    has_attached_file :documento, styles: { large: "600x600>", medium: "300x300>", :thumb => ["40x40>", :png] }, default_url: "/system/resources/missing_32.png"
    validates_attachment :documento,
        content_type: { content_type: "application/pdf" },
        size: { in: 0..5000.kilobytes }
    validates_presence_of :descripcion

    def self.tipos_sancion
      %w(Amonestación Multa Comisión Disolución Otro)
    end

end
