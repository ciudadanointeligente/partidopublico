class AddPartidoToAfiliacion < ActiveRecord::Migration
  def change
    add_reference :afiliacions, :partido, index: true, foreign_key: true
  end
end
