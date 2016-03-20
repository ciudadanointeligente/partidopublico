class Partido < ActiveRecord::Base
    validates_presence_of :nombre, :sigla, :lema, :message => "debe rellenar"
    validates_uniqueness_of :nombre, :sigla, :lema, :message => "already exists"
    validates_length_of :lema, :within => 2..200
end
