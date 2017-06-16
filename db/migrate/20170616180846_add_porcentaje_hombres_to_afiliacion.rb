class AddPorcentajeHombresToAfiliacion < ActiveRecord::Migration
  def change
    add_column :afiliacions, :porcentaje_hombres, :string
  end
end
