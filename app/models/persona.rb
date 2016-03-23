class Persona < ActiveRecord::Base
    has_attached_file :foto, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment :foto,
        content_type: { content_type:  /\Aimage\/.*\Z/ },
        size: { in: 0..500.kilobytes }
    validates_presence_of :nombre, :apellidos, :message => "debe rellenar"
    
    belongs_to :partido
    belongs_to :personable, polymorphic: true
    
end
