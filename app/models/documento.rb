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
#
# Indexes
#
#  index_documentos_on_documentable_type_and_documentable_id  (documentable_type,documentable_id)
#

class Documento < ActiveRecord::Base
    has_paper_trail
    has_attached_file :archivo, styles: { large: "600x600>", medium: "300x300>", :thumb => ["40x40>", :png] }, default_url: "/system/resources/missing_32.png"
    validates_attachment :archivo, 
        content_type: { content_type: "application/pdf" },
        size: { in: 0..5000.kilobytes }
    validates_presence_of :descripcion
    belongs_to :documentable, polymorphic: true
end
