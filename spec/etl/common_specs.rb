
require 'rails_helper'
require 'etl/scripts/common'

RSpec.describe EtlRun  do
  it "test true" do
    result = clean_number("43")
    expect(result).to eq(43)
  end
  it "clean_phrase funciona perrito papá!" do
    r = clean_phrase("cotizaciones")
    expect(r).to eq('Cotizaciones')
    expect(clean_phrase("perritoestamentarias")).to eq('Asignaciones testamentarias')
    expect(clean_phrase("frutos y productos")).to eq("Frutos y productos de los bienes patrimoniales")
    expect(clean_phrase("aportes del estado")).to eq("Aportes del Estado (Art. 33 Bis Ley N° 18603)")
    expect(clean_phrase("blicas")).to eq("Otras transferencias públicas")
    expect(clean_phrase("privadas")).to eq("Otras transferencias privadas")
    expect(clean_phrase("gresos militantes")).to eq("Ingresos militantes")
    expect(clean_phrase("personal")).to eq("Gastos de personal")
    expect(clean_phrase("gastos corrientes")).to eq("Gastos de adquisición de bienes y servicios o gastos corrientes")
    expect(clean_phrase("préstamos de corto plazo")).to eq("Gastos financieros por préstamos de corto plazo")
    expect(clean_phrase("préstamos de largo plazo")).to eq("Gastos financieros por préstamos de largo plazo")
    expect(clean_phrase("administraci")).to eq("Otros gastos de administración")
    expect(clean_phrase("investigaci")).to eq("Gastos de actividades de investigación")
    expect(clean_phrase("educación cívica")).to eq("Gastos de actividades de educación cívica")
    expect(clean_phrase("femenina")).to eq("Gastos de actividades de fomento a la particiación femenina")
    expect(clean_phrase("de los j")).to eq( "Gastos de actividades de fomento a la participación de los jóvenes")
    expect(clean_phrase("corto plazo, inversiones")).to eq( "Créditos de corto plazo, inversiones y valores de operaciones de capital")
    expect(clean_phrase("largo plazo, inversiones")).to eq( "Créditos de largo plazo, inversiones y valores de operaciones de capital")
    expect(clean_phrase("de candidatos a cargos de elecc")).to eq( "Gastos de las actividades de preparación de candidatos a cargos de elección popular")
    expect(clean_phrase("n de militantes")).to eq( "Gastos de las actividades de formación de militantes")
  end
end
