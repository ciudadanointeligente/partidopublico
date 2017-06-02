class AddJunioToEgresoOrdinario < ActiveRecord::Migration
  def change
    add_column :egreso_ordinarios, :junio, :int
  end
end
