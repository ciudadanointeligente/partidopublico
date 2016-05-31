class AddPartidoRefToSancion < ActiveRecord::Migration
  def change
    add_reference :sancions, :partido, index: true, foreign_key: true
  end
end
