class AddSeptiembreToEgresoOrdinario < ActiveRecord::Migration
  def change
    add_column :egreso_ordinarios, :septiembre, :int
  end
end
