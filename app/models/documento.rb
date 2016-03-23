class Documento < ActiveRecord::Base
    has_attached_file :archivo, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment :archivo, 
        content_type: { content_type: "application/pdf" },
        size: { in: 0..5000.kilobytes }
        
    belongs_to :documentable, polymorphic: true
end
