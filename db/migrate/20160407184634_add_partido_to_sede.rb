class AddPartidoToSede < ActiveRecord::Migration
  def change
    add_reference :sedes, :partido, index: true, foreign_key: true
  end
end
