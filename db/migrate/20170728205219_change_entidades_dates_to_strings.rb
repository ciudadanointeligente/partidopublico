class ChangeEntidadesDatesToStrings < ActiveRecord::Migration
  def change
    change_column :participacion_entidads, :fecha_inicio, :string
    change_column :participacion_entidads, :fecha_fin, :string
  end
end
