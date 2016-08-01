class AddTipoVinculoAndDatesToParticipacionEntidad < ActiveRecord::Migration
  def change
    add_column :participacion_entidads, :tipo_vinculo, :string
    add_column :participacion_entidads, :fecha_inicio, :date
    add_column :participacion_entidads, :fecha_fin, :date
  end
end
