# == Schema Information
#
# Table name: trimestre_informados
#
#  id         :integer          not null, primary key
#  ano        :integer
#  trimestre  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ordinal    :integer
#

class TrimestreInformado < ActiveRecord::Base
  has_and_belongs_to_many :sedes
  has_and_belongs_to_many :organo_internos
  has_and_belongs_to_many :cargos
  has_and_belongs_to_many :egreso_ordinarios
  has_and_belongs_to_many :ingreso_ordinarios
  has_and_belongs_to_many :transferencias
  has_and_belongs_to_many :contratacions
  has_and_belongs_to_many :egreso_campanas
  has_and_belongs_to_many :ingreso_campanas
  has_and_belongs_to_many :afiliacions
  has_and_belongs_to_many :sancions
  has_and_belongs_to_many :estadistica_cargos
  has_and_belongs_to_many :pacto_electorals
  has_and_belongs_to_many :acuerdos
  has_and_belongs_to_many :participacion_entidads
  has_and_belongs_to_many :tramites
  validates_presence_of :ordinal

  def to_s
    self.ano.to_s + ' ' + self.trimestre.to_s
  end

  def porcentaje_completado
    nota_partidos = []
    t = self
    Partido.all.each do |p|
      sedes = t.sedes.where(partido: p).any? ? 1 : 0
      organos = t.organo_internos.where(partido: p).any? ? 1 : 0
      cargos = t.cargos.where(partido: p).any? ? 1 : 0
      egreso_ordinarios = t.egreso_ordinarios.where(partido: p).any? ? 1 : 0
      ingreso_ordinarios = t.ingreso_ordinarios.where(partido: p).any? ? 1 : 0
      transferencias = t.transferencias.where(partido: p).any? ? 1 : 0
      contratacions = t.contratacions.where(partido: p).any? ? 1 : 0
      egreso_campanas = t.egreso_campanas.where(partido: p).any? ? 1 : 0
      ingreso_campanas = t.ingreso_campanas.where(partido: p).any? ? 1 : 0
      afiliacions = t.afiliacions.where(partido: p).any? ? 1 : 0
      sancions = t.sancions.where(partido: p).any? ? 1 : 0
      estadistica_cargos = t.estadistica_cargos.where(partido: p).any? ? 1 : 0
      pacto_electorals = t.pacto_electorals.where(partido: p).any? ? 1 : 0
      acuerdos = t.acuerdos.where(partido: p).any? ? 1 : 0
      participacion_entidads = t.participacion_entidads.where(partido: p).any? ? 1 : 0
      tramites = t.tramites.where(partido: p).any? ? 1 : 0
      tmp = sedes + organos + cargos + egreso_ordinarios + ingreso_ordinarios + transferencias + contratacions + egreso_campanas + ingreso_campanas + afiliacions + sancions + estadistica_cargos + pacto_electorals + acuerdos + participacion_entidads + tramites

      nota_partidos << { "partido_id" => p.id, "suma" => tmp, "total" => 16, "nota" => (tmp.to_f / 16.0) }
    end
    nota_partidos
  end

  def self.current_trimestre(date=nil)
    today = date.nil? ? Date.today : Date.new(date.to_s[0..3].to_i, date.to_s[4..5].to_i, date.to_s[6..7].to_i)
    # p "today: " + today.to_s
    year = today.year
    month = today.month
    day = today.day
    tmp_ordinal = ((month - 1) / 3)
    tmp_mod = ((month - 1) % 3)
    if tmp_mod == 0
      if day < 10
        if tmp_ordinal > 0
          tmp_ordinal = tmp_ordinal -1
        else
          year = year -1
          tmp_ordinal = 3
        end
      end
    end
    TrimestreInformado.where(ano: year).where(ordinal: tmp_ordinal).first
  end

  def next
    if self.ordinal == 3
      year = self.ano + 1
      tmp_ordinal = 0
    else
      year = self.ano
      tmp_ordinal = self.ordinal + 1
    end
    TrimestreInformado.where(ano: year).where(ordinal: tmp_ordinal).first
  end

  def prev
    if self.ordinal == 0
      year = self.ano - 1
      tmp_ordinal = 3
    else
      year = self.ano
      tmp_ordinal = self.ordinal - 1
    end
    TrimestreInformado.where(ano: year).where(ordinal: tmp_ordinal).first
  end

  def total_ingresos
    ingresos_partidos = []
    t = self
    p t.to_s
    Partido.all.each do |p|
      ingreso_ordinarios = t.ingreso_ordinarios.where(partido: p).sum(:importe)
      ingresos_partidos << { "partido_id" => p.id, "suma_ingresos" => ingreso_ordinarios }
    end
    ingresos_partidos
  end

  def total_gastos
    gastos_partidos = []
    trimestre = self
    p trimestre.to_s
    Partido.all.each do |p|
      g = trimestre.egreso_ordinarios.where(partido: p)
        if trimestre.ordinal == 0
          val = (g.sum(:enero) + g.sum(:febrero) + g.sum(:marzo) rescue 0)
        elsif trimestre.ordinal == 1
          val = (g.sum(:abril) + g.sum(:mayo) + g.sum(:junio) rescue 0)
        elsif trimestre.ordinal == 2
          val = (g.sum(:julio) + g.sum(:agosto) + g.sum(:septiembre) rescue 0)
        elsif trimestre.ordinal == 3
          val = (g.sum(:octubre) + g.sum(:noviembre) + g.sum(:diciembre) rescue 0)
        end

      gastos_partidos << { "partido_id" => p.id, "suma_gastos" => val }
    end
    gastos_partidos
  end

end
