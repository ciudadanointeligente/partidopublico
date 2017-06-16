class AddPorcentajeMujeresToAfiliacion < ActiveRecord::Migration
  def change
    add_column :afiliacions, :porcentaje_mujeres, :string
  end
end
