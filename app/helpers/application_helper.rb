module ApplicationHelper

  def tipos_egresos_ordinarios
    [
      {
        :categoria => 'Gastos Administrativos',
        :tipos => ["Gastos de personal", "Gastos de adquisición de bienes y servicios o gastos corrientes", "Otros gastos de administración"]
      },
      {
        :categoria => 'Préstamos, Créditos o Inversiones',
        :tipos => ["Gastos financieros por préstamos de corto plazo", "Gastos financieros por préstamos de largo plazo", "Créditos de corto plazo, inversiones y valores de operaciones de capital", "Créditos de largo plazo, inversiones y valores de operaciones de capital"]
      },
      {
        :categoria => 'Gastos de Participación y Formación',
        :tipos => ["Gastos de actividades de investigación",
                  "Gastos de actividades de educación cívica",
                  "Gastos de actividades de fomento a la participación femenina",
                  "Gastos de actividades de fomento a la participación de los jóvenes",
                  "Gastos de las actividades de preparación de candidatos a cargos de elección popular",
                  "Gastos de las actividades de formación de militantes"]
      }
    ]
  end

  def gasto_por_trimeste(trimestre, gasto)
    if trimestre.ordinal == 0
      gastos = (gasto.enero + gasto.febrero + gasto.marzo) rescue 0
    elsif trimestre.ordinal == 1
      gastos = (gasto.abril + gasto.mayo + gasto.junio) rescue 0
    elsif trimestre.ordinal == 2
      gastos = (gasto.julio + gasto.agosto + gasto.septiembre) rescue 0
    elsif trimestre.ordinal == 3
      gastos = (gasto.octubre + gasto.noviembre + gasto.diciembre) rescue 0
    end
    gastos
  end

  def meses(trimestre)
    meses = ''
    if trimestre.ordinal == 0
      meses = 'enero + febrero + marzo'
    elsif trimestre.ordinal == 1
      meses = 'abril + mayo + junio'
    elsif trimestre.ordinal == 2
      meses = 'julio + agosto + septiembre'
    elsif trimestre.ordinal == 3
      meses = 'octubre + noviembre + diciembre'
    end
    meses
  end

  def val_egresos_ordinarios(trimestre, egreso_ordinario, max_value)
    if trimestre.ordinal == 0
      val = (((egreso_ordinario.enero.to_f + egreso_ordinario.febrero.to_f + egreso_ordinario.marzo.to_f) / max_value.to_f).to_f rescue 0).to_s
    elsif trimestre.ordinal == 1
      val = (((egreso_ordinario.abril.to_f + egreso_ordinario.mayo.to_f + egreso_ordinario.junio.to_f) / max_value.to_f).to_f rescue 0).to_s
    elsif trimestre.ordinal == 2
      val = (((egreso_ordinario.julio.to_f + egreso_ordinario.agosto.to_f + egreso_ordinario.septiembre.to_f) / max_value.to_f).to_f rescue 0).to_s
    elsif trimestre.ordinal == 3
      val = (((egreso_ordinario.octubre.to_f + egreso_ordinario.noviembre.to_f + egreso_ordinario.diciembre.to_f) / max_value.to_f).to_f rescue 0).to_s
    end
  end

  def line_egresos_ordinarios(trimestre, egreso_ordinario, val)
    if trimestre.ordinal == 0
      line = {'text' => egreso_ordinario.concepto,
              'value' => ActiveSupport::NumberHelper::number_to_delimited((egreso_ordinario.enero + egreso_ordinario.febrero + egreso_ordinario.marzo), delimiter: ""),
              'percentage' => val }
      @datos_egresos_ordinarios << line unless (egreso_ordinario.enero + egreso_ordinario.febrero + egreso_ordinario.marzo) == 0
    elsif trimestre.ordinal == 1
      line = {'text' => egreso_ordinario.concepto,
              'value' => ActiveSupport::NumberHelper::number_to_delimited((egreso_ordinario.abril + egreso_ordinario.mayo + egreso_ordinario.junio), delimiter: ""),
              'percentage' => val }
      @datos_egresos_ordinarios << line unless (egreso_ordinario.abril + egreso_ordinario.mayo + egreso_ordinario.junio) == 0
    elsif trimestre.ordinal == 2
      line = {'text' => egreso_ordinario.concepto,
              'value' => ActiveSupport::NumberHelper::number_to_delimited((egreso_ordinario.julio + egreso_ordinario.agosto + egreso_ordinario.septiembre), delimiter: ""),
              'percentage' => val }
      @datos_egresos_ordinarios << line unless (egreso_ordinario.julio + egreso_ordinario.agosto + egreso_ordinario.septiembre) == 0
    elsif trimestre.ordinal == 3
      line = {'text' => egreso_ordinario.concepto,
              'value' => ActiveSupport::NumberHelper::number_to_delimited((egreso_ordinario.octubre + egreso_ordinario.noviembre + egreso_ordinario.diciembre), delimiter: ""),
              'percentage' => val }
      @datos_egresos_ordinarios << line unless (egreso_ordinario.octubre + egreso_ordinario.noviembre + egreso_ordinario.diciembre) == 0
    end
  end

end
