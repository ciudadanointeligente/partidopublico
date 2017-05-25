class AddAbrilToEgresoOrdinario < ActiveRecord::Migration
  def change
    add_column :egreso_ordinarios, :Abril, :int
  end
end
