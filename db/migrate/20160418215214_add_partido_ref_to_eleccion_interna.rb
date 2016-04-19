class AddPartidoRefToEleccionInterna < ActiveRecord::Migration
  def change
    add_reference :eleccion_internas, :partido, index: true, foreign_key: true
  end
end
