class AddRangoEtarioToAfiliacion < ActiveRecord::Migration
  def change
    add_column :afiliacions, :rango_etareo, :string
  end
end
