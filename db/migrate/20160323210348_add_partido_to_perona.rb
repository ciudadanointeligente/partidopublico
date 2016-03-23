class AddPartidoToPerona < ActiveRecord::Migration
  def change
    add_reference :personas, :partido, index: true, foreign_key: true
  end
end
