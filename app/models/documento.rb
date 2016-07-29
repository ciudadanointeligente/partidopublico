# == Schema Information
#
# Table name: documentos
#
#  id                   :integer          not null, primary key
#  descripcion          :string
#  documentable_id      :integer
#  documentable_type    :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  archivo_file_name    :string
#  archivo_content_type :string
#  archivo_file_size    :integer
#  archivo_updated_at   :datetime
#  obligatorio          :boolean
#  explicacion          :string
#
# Indexes
#
#  index_documentos_on_documentable_type_and_documentable_id  (documentable_type,documentable_id)
#

class Documento < ActiveRecord::Base
    has_paper_trail
    has_attached_file :archivo, default_url: "/system/resources/missing_32.png"
    validates_attachment :archivo,
        content_type: { content_type: ["application/pdf", "application/vnd.oasis.opendocument.spreadsheet", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet","application/msword",
        "application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"] },
        size: { in: 0..5000.kilobytes }
    validates_presence_of :descripcion
    belongs_to :documentable, polymorphic: true
    has_many :categoria_financieras


    def importar_finanzas
      ods = Roo::Spreadsheet.open self.archivo
      ods.sheets.each do |s|
        c = CategoriaFinanciera.new
        c.partido = self.documentable.partido
        c.documento = self
        c.titulo = s.to_s
        c.fecha = Date.today
        c.save
        (2..ods.sheet(s).last_row).each do |line|
          puts line
          i = ItemContable.new
          i.categoria_financiera = c
          i.concepto = ods.sheet(s).cell(line,1)
          i.importe = ods.sheet(s).cell(line,2)
          #i.dinero_publico = ods.sheet(s).cell(line,3)
          i.save
        end
      end
    end
end
