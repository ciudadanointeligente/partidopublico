# == Schema Information
#
# Table name: marco_generals
#
#  id         :integer          not null, primary key
#  partido_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MarcoGeneral < ActiveRecord::Base
  belongs_to :partido
  has_many :leys, dependent: :destroy
  
  accepts_nested_attributes_for :leys
  
  after_create :populate
  
  def populate
    self.leys<< Ley.new(numero:"Decreto 100	", nombre:"Constitución política de la República 	", enlace:"http://www.leychile.cl/Navegar?idNorma=242302	")
    self.leys<< Ley.new(numero:"20.880	", nombre:"SOBRE PROBIDAD EN LA FUNCIÓN PÚBLICA Y PREVENCIÓN DE LOS CONFLICTOS DE INTERESES	", enlace:"http://bcn.cl/1tvyr	")
    self.leys<< Ley.new(numero:"20.840	", nombre:"SUSTITUYE EL SISTEMA ELECTORAL BINOMINAL POR UNO DE CARÁCTER PROPORCIONAL INCLUSIVO Y FORTALECE LA REPRESENTATIVIDAD DEL CONGRESO NACIONAL	", enlace:"http://www.leychile.cl/Navegar?idNorma=1077039	")
    self.leys<< Ley.new(numero:"20.568	", nombre:"REGULA LA INSCRIPCIÓN AUTOMÁTICA, MODIFICA EL SERVICIO ELECTORAL Y MODERNIZA EL SISTEMA DE VOTACIONES	", enlace:"http://www.leychile.cl/Navegar?idNorma=1035420	")
    self.leys<< Ley.new(numero:"20.542	", nombre:"RELATIVA AL PLAZO DE RENUNCIA A UN PARTIDO POLÍTICO PARA PRESENTAR CANDIDATURAS INDEPENDIENTES	", enlace:"http://bcn.cl/1rq6w	")
    self.leys<< Ley.new(numero:"20.515	", nombre:"REFORMA CONSTITUCIONAL PARA ADECUAR LOS PLAZOS VINCULADOS A LAS ELECCIONES PRESIDENCIALES	", enlace:"http://bcn.cl/1qh2w	")
    self.leys<< Ley.new(numero:"20.337	", nombre:"REFORMA CONSTITUCIONAL QUE MODIFICA LOS ARTÍCULOS 15 Y 18 DE LA CARTA FUNDAMENTAL CON EL OBJETO DE CONSAGRAR EL SUFRAGIO COMO UN DERECHO DE LOS CIUDADANOS Y SU INSCRIPCIÓN AUTOMÁTICA EN LOS REGISTROS ELECTORALES	", enlace:"http://bcn.cl/1so4f	")
    self.leys<< Ley.new(numero:"19.885	", nombre:"INCENTIVA Y NORMA EL BUEN USO DE DONACIONES QUE DAN ORIGEN A BENEFICIOS TRIBUTARIOS Y LOS EXTIENDE A OTROS FINES SOCIALES Y PÚBLICOS	", enlace:"http://bcn.cl/1lzqc	")
    self.leys<< Ley.new(numero:"19.884	", nombre:"SOBRE TRANSPARENCIA, LIMITE Y CONTROL DEL GASTO ELECTORAL	", enlace:"http://bcn.cl/1m3aj	")
    self.leys<< Ley.new(numero:"18.700	", nombre:"LEY ORGANICA CONSTITUCIONAL SOBRE VOTACIONES POPULARES Y ESCRUTINIOS	", enlace:"http://bcn.cl/1m9ud	")
    self.leys<< Ley.new(numero:"18.603	", nombre:"EY ORGANICA CONSTITUCIONAL DE LOS PARTIDOS POLITICOS	", enlace:"	ttp://bcn.cl/1m18t	")
    self.leys<< Ley.new(numero:"18.556	", nombre:"LEY ORGANICA CONSTITUCIONAL SOBRE SISTEMA DE INSCRIPCIONES ELECTORALES Y SERVICIO ELECTORAL	", enlace:"http://bcn.cl/1mnss	")
    self.leys<< Ley.new(numero:"18.460	", nombre:"ESTABLECE LA LEY ORGANICA CONSTITUCIONAL DEL TRIBUNAL CALIFICADOR DE ELECCIONES	", enlace:"http://bcn.cl/1mzms	")
    self.leys<< Ley.new(numero:"DFL 1-2006	", nombre:"FIJA EL TEXTO REFUNDIDO, COORDINADO Y SISTEMATIZADO DE LA LEY Nº 18.695, ORGANICA CONSTITUCIONAL DE MUNICIPALIDADES	", enlace:"http://bcn.cl/1lzeb	")
    self.leys<< Ley.new(numero:"DFL 1-2005	", nombre:"", enlace:"")
  end
end
