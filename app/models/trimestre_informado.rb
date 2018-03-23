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

      nota_partidos << { "partido_id" => p.id, "suma" => tmp, "total" => 16, "nota" => (tmp.to_f / 16.0), "ano" => t.ano, "ordinal" => t.ordinal }
    end
    nota_partidos.sort_by{|i| - i['nota']}
  end

  def self.current_trimestre(date=nil)
    today = date.nil? ? Date.today : Date.new(date.to_s[0..3].to_i, date.to_s[4..5].to_i, date.to_s[6..7].to_i)
    # p "today: " + today.to_s
    year = today.year
    month = today.month
    day = today.day
    tmp_ordinal = ((month - 1) / 3)
    tmp_mod = ((month - 1) % 3)
    p "y: " + year.to_s + " m: " + month.to_s + " d:" + day.to_s
    p "tmp_ordinal : " + tmp_ordinal.to_s + ", tmp_mod : " + tmp_mod.to_s
    if tmp_mod = 0
      if day < 14
        if tmp_ordinal == 0
          tmp_ordinal = 3
          year = year -1
        else
          tmp_ordinal = tmp_ordinal -1
        end
      else
        if tmp_ordinal == 0
          tmp_ordinal = 3
          year = year -1
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
      ingresos_partidos << { "partido_id" => p.id, "suma_ingresos" => ingreso_ordinarios, "ano" => t.ano, "ordinal" => t.ordinal, "trimestre" => t.trimestre }
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

      gastos_partidos << { "partido_id" => p.id, "suma_gastos" => val, "ano" => trimestre.ano, "ordinal" => trimestre.ordinal, "trimestre" => trimestre.trimestre}
    end
    gastos_partidos
  end

  def self.gastos_3_ultimos
    trimestre = TrimestreInformado.current_trimestre
    gastos = []
    # gastos << trimestre.prev.total_gastos
    # gastos << trimestre.prev.prev.total_gastos
    # gastos << trimestre.prev.prev.prev.total_gastos
    # gastos.map { |h| h['partido_id'] }.uniq.map{|p| {'partido_id' => p, 'gastos' => gastos.select{|v| v['partido_id']==p} }}

    # gastos
    gastos = trimestre.prev.total_gastos.concat(trimestre.prev.prev.total_gastos).concat( trimestre.prev.prev.prev.total_gastos)
    gastos.map { |h| h['partido_id'] }.uniq.map{|p| {
                            'partido_id' => p,
                            'gastos' => gastos.select{|v| v['partido_id']==p},
                            'suma' => gastos.select{|v| v['partido_id']==p}.inject(0){ |sum,x| sum + x["suma_gastos"] } } }.sort_by{|h| - h["suma"]}

  end

  def self.ingresos_3_ultimos
    trimestre = TrimestreInformado.current_trimestre
    ingresos = []
    # ingresos << trimestre.prev.total_ingresos
    # ingresos << trimestre.prev.prev.total_ingresos
    # ingresos << trimestre.prev.prev.prev.total_ingresos
    # ingresos.map { |h| h['partido_id'] }.uniq.map{|p| {'partido_id' => p, 'ingresos' => ingresos.select{|v| v['partido_id']==p} }}

    # ingresos
    ingresos = trimestre.prev.total_ingresos.concat(trimestre.prev.prev.total_ingresos).concat( trimestre.prev.prev.prev.total_ingresos)
    ingresos.map { |h| h['partido_id'] }.uniq.map{|p| {
                            'partido_id' => p,
                            'ingresos' => ingresos.select{|v| v['partido_id']==p},
                            'suma' => ingresos.select{|v| v['partido_id']==p}.inject(0){ |sum,x| sum + x["suma_ingresos"] } } }.sort_by{|h| - h["suma"]}

  end

  def self.proporcion_sexos
    trimestre = TrimestreInformado.current_trimestre
    trimestre.prev.afiliacions.where(rango_etareo: 'total militantes').sort_by{|a| -(a.hombres + a.mujeres)}
  end
end
