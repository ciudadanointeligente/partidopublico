class AddFebreroToEgresoOrdinario < ActiveRecord::Migration
  def change
    add_column :egreso_ordinarios, :febrero, :int
  end
end
