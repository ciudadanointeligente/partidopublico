class AddNoviembreToEgresoOrdinario < ActiveRecord::Migration
  def change
    add_column :egreso_ordinarios, :noviembre, :int
  end
end
