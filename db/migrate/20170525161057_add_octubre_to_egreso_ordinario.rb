class AddOctubreToEgresoOrdinario < ActiveRecord::Migration
  def change
    add_column :egreso_ordinarios, :octubre, :int
  end
end
