class AddDiciembreToEgresoOrdinario < ActiveRecord::Migration
  def change
    add_column :egreso_ordinarios, :diciembre, :int
  end
end
