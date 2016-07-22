class AddFechaDatosToAfiliacion < ActiveRecord::Migration
  def change
     add_column :afiliacions, :fecha_datos, :date
  end
end
