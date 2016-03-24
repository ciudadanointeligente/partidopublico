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

class Documento < ActiveRecord::Base
    has_attached_file :archivo, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment :archivo, 
        content_type: { content_type: "application/pdf" },
        size: { in: 0..5000.kilobytes }
        
    belongs_to :documentable, polymorphic: true
end
