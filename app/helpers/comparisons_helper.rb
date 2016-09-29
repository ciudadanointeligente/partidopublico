module ComparisonsHelper
  def categories
    categories = ["Afiliados según género",
                  "Afiliados según rango etario",
                  "Regiones constituidos",
                  "Representantes electos",
                  "Ingresos ordinarios"
                ]
  end

  def roman_ordinals
    ["I","II","III","IV","V","VI","VII","VIII","IX","X","XI","XII","RM","XIV","XV"]
  end

  def rangos_etarios
    [[14,17],[18,24],[25,29],[30,34],[35,39],[40,44],[45,49],[50,54],[55,59],[60,64],[65,69],[70,100]]
  end
end
