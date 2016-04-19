class AddPartidoRefToEleccionPopular < ActiveRecord::Migration
  def change
    add_reference :eleccion_populars, :partido, index: true, foreign_key: true
  end
end
