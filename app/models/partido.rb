class Partido < ActiveRecord::Base
    has_paper_trail
    has_attached_file :logo, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment :logo,
        content_type: { content_type:  /\Aimage\/.*\Z/ },
        size: { in: 0..500.kilobytes }
    validates_presence_of :nombre, :sigla, :lema, :message => "debe rellenar"
    validates_uniqueness_of :nombre, :sigla, :lema, :message => "already exists"
    validates_length_of :lema, :within => 2..200
    
end
