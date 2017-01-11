class AddPartidoRefToNorma < ActiveRecord::Migration
  def change
    add_reference :normas, :partido, index: true, foreign_key: true
  end
end
