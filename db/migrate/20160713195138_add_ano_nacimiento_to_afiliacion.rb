class AddAnoNacimientoToAfiliacion < ActiveRecord::Migration
  def change
     add_column :afiliacions, :ano_nacimiento, :integer
  end
end
