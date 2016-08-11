class AddPartidoRefToIngresoOrdinario < ActiveRecord::Migration
  def change

      add_reference :ingreso_ordinarios, :partido, index: true, foreign_key: true  
  end
end
